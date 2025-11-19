DELIMITER //

CREATE PROCEDURE sp_crear_presupuesto_completo(
    IN p_id_usuario INT,
    IN p_nombre_presupuesto VARCHAR(150),
    IN p_anio_inicio INT,
    IN p_mes_inicio INT,
    IN p_anio_fin INT,
    IN p_mes_fin INT,
    IN p_estado VARCHAR(50),
    IN p_lista_detalles_json JSON,
    IN p_creado_por VARCHAR(100)
)
BEGIN
    DECLARE v_id_presupuesto INT;

    INSERT INTO presupuesto(
        id_usuario, nombre_presupuesto,
        anio_inicio, mes_inicio,
        anio_fin, mes_fin,
        estado, fecha_hora_creacion,
        creado_por, creado_en
    )
    VALUES(
        p_id_usuario, p_nombre_presupuesto,
        p_anio_inicio, p_mes_inicio,
        p_anio_fin, p_mes_fin,
        p_estado, NOW(),
        p_creado_por, NOW()
    );

    SET v_id_presupuesto = LAST_INSERT_ID();

    INSERT INTO presupuesto_detalle(id_presupuesto, id_subcategoria, monto_mensual, observacion, creado_por, creado_en)
    SELECT 
        v_id_presupuesto,
        JSON_EXTRACT(j.value, '$.id_subcategoria'),
        JSON_EXTRACT(j.value, '$.monto_mensual'),
        JSON_EXTRACT(j.value, '$.observacion'),
        p_creado_por,
        NOW()
    FROM JSON_TABLE(p_lista_detalles_json, "$[*]" COLUMNS(value JSON PATH "$")) AS j;
END //

CREATE PROCEDURE sp_registrar_transaccion_completa(
    IN p_id_usuario INT,
    IN p_id_presupuesto INT,
    IN p_id_subcategoria INT,
    IN p_id_obligacion_fija INT,
    IN p_tipo_transaccion VARCHAR(50),
    IN p_descripcion VARCHAR(255),
    IN p_monto DECIMAL(10,2),
    IN p_fecha DATE,
    IN p_metodo_pago VARCHAR(100),
    IN p_numero_factura VARCHAR(100),
    IN p_observaciones VARCHAR(255),
    IN p_creado_por VARCHAR(100)
)
BEGIN
    INSERT INTO transaccion(
        id_usuario, id_presupuesto, id_subcategoria, id_obligacion_fija,
        tipo_transaccion, descripcion, monto, fecha, metodo_pago,
        numero_factura, observaciones, fecha_hora_registro,
        creado_por, creado_en
    )
    VALUES(
        p_id_usuario, p_id_presupuesto, p_id_subcategoria, p_id_obligacion_fija,
        p_tipo_transaccion, p_descripcion, p_monto, p_fecha, p_metodo_pago,
        p_numero_factura, p_observaciones, NOW(),
        p_creado_por, NOW()
    );
END //

CREATE PROCEDURE sp_procesar_obligaciones_mes(
    IN p_id_usuario INT,
    IN p_anio INT,
    IN p_mes INT
)
BEGIN
    SELECT *
    FROM obligacion_fija
    WHERE id_usuario = p_id_usuario
      AND estado = 'activa'
      AND MONTH(fecha_inicio) <= p_mes
      AND (fecha_finalizacion IS NULL OR MONTH(fecha_finalizacion) >= p_mes);
END //

CREATE PROCEDURE sp_calcular_balance_mensual(
    IN p_id_usuario INT,
    IN p_id_presupuesto INT,
    IN p_anio INT,
    IN p_mes INT
)
BEGIN
    SELECT
        SUM(IF(tipo_transaccion='ingreso', monto, 0)) AS total_ingresos,
        SUM(IF(tipo_transaccion='gasto', monto, 0)) AS total_gastos,
        SUM(IF(tipo_transaccion='ahorro', monto, 0)) AS total_ahorros,
        SUM(IF(tipo_transaccion='ingreso', monto, 0))
        - SUM(IF(tipo_transaccion='gasto', monto, 0))
        - SUM(IF(tipo_transaccion='ahorro', monto, 0)) AS balance_final
    FROM transaccion
    WHERE id_usuario = p_id_usuario
      AND id_presupuesto = p_id_presupuesto
      AND YEAR(fecha) = p_anio
      AND MONTH(fecha) = p_mes;
END //

CREATE PROCEDURE sp_calcular_monto_ejecutado_mes(
    IN p_id_subcategoria INT,
    IN p_anio INT,
    IN p_mes INT
)
BEGIN
    SELECT SUM(monto) AS monto_ejecutado
    FROM transaccion
    WHERE id_subcategoria = p_id_subcategoria
      AND YEAR(fecha) = p_anio
      AND MONTH(fecha) = p_mes;
END //

CREATE PROCEDURE sp_calcular_porcentaje_ejecucion_mes(
    IN p_id_subcategoria INT,
    IN p_id_presupuesto INT,
    IN p_anio INT,
    IN p_mes INT
)
BEGIN
    DECLARE v_pres DECIMAL(10,2) DEFAULT 0;
    DECLARE v_exec DECIMAL(10,2) DEFAULT 0;

    SELECT monto_mensual INTO v_pres
    FROM presupuesto_detalle
    WHERE id_subcategoria = p_id_subcategoria
      AND id_presupuesto = p_id_presupuesto;

    SELECT SUM(monto) INTO v_exec
    FROM transaccion
    WHERE id_subcategoria = p_id_subcategoria
      AND YEAR(fecha) = p_anio
      AND MONTH(fecha) = p_mes;

    SELECT (v_exec / v_pres) * 100 AS porcentaje;
END //

CREATE PROCEDURE sp_verificar_generar_alertas_presupuesto(
    IN p_id_presupuesto INT,
    IN p_anio INT,
    IN p_mes INT
)
BEGIN
    SELECT
        sc.nombre_subcategoria,
        pd.monto_mensual AS presupuestado,
        SUM(t.monto) AS ejecutado,
        (SUM(t.monto) / pd.monto_mensual) * 100 AS porcentaje
    FROM presupuesto_detalle pd
    LEFT JOIN transaccion t
        ON pd.id_subcategoria = t.id_subcategoria
        AND YEAR(t.fecha) = p_anio
        AND MONTH(t.fecha) = p_mes
    JOIN subcategoria sc ON sc.id_subcategoria = pd.id_subcategoria
    WHERE pd.id_presupuesto = p_id_presupuesto
    GROUP BY pd.id_subcategoria;
END //

CREATE PROCEDURE sp_actualizar_todas_metas_ahorro(
    IN p_id_usuario INT
)
BEGIN
    UPDATE meta_ahorro m
    JOIN (
        SELECT id_subcategoria, SUM(monto) AS total
        FROM transaccion
        WHERE tipo_transaccion = 'ahorro'
        GROUP BY id_subcategoria
    ) t ON m.id_subcategoria = t.id_subcategoria
    SET m.monto_ahorrado = t.total
    WHERE m.id_usuario = p_id_usuario;
END //

CREATE PROCEDURE sp_cerrar_presupuesto(
    IN p_id_presupuesto INT,
    IN p_modificado_por VARCHAR(100)
)
BEGIN
    UPDATE presupuesto
    SET estado = 'cerrado',
        modificado_por = p_modificado_por,
        modificado_en = NOW()
    WHERE id_presupuesto = p_id_presupuesto;
END //

CREATE PROCEDURE sp_distribuir_presupuesto_automatico(
    IN p_id_usuario INT,
    IN p_id_presupuesto INT
)
BEGIN
    SELECT sc.id_subcategoria, AVG(t.monto) AS promedio
    FROM transaccion t
    JOIN subcategoria sc ON sc.id_subcategoria = t.id_subcategoria
    WHERE t.id_usuario = p_id_usuario
    GROUP BY sc.id_subcategoria;
END //

CREATE PROCEDURE sp_obtener_resumen_categoria_mes(
    IN p_id_categoria INT,
    IN p_anio INT,
    IN p_mes INT
)
BEGIN
    SELECT
        c.nombre_categoria,
        SUM(pd.monto_mensual) AS monto_presupuestado,
        SUM(t.monto) AS monto_ejecutado,
        (SUM(t.monto) / SUM(pd.monto_mensual)) * 100 AS porcentaje
    FROM categoria c
    JOIN subcategoria sc ON sc.id_categoria = c.id_categoria
    JOIN presupuesto_detalle pd ON pd.id_subcategoria = sc.id_subcategoria
    LEFT JOIN transaccion t ON t.id_subcategoria = sc.id_subcategoria
         AND YEAR(t.fecha) = p_anio
         AND MONTH(t.fecha) = p_mes
    WHERE c.id_categoria = p_id_categoria
    GROUP BY c.id_categoria;
END //

DELIMITER ;
