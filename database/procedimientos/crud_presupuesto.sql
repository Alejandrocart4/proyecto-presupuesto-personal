DELIMITER //

-- CREATE
CREATE PROCEDURE sp_presupuesto_create(
    IN p_id_usuario        INT,
    IN p_nombre_presupuesto VARCHAR(150),
    IN p_anio_inicio       INT,
    IN p_mes_inicio        INT,
    IN p_anio_fin          INT,
    IN p_mes_fin           INT,
    IN p_total_ingresos    DECIMAL(10,2),
    IN p_total_gastos      DECIMAL(10,2),
    IN p_total_ahorro      DECIMAL(10,2),
    IN p_estado            VARCHAR(50),
    IN p_creado_por        VARCHAR(100)
)
BEGIN
    INSERT INTO presupuesto(
        id_usuario, nombre_presupuesto,
        anio_inicio, mes_inicio,
        anio_fin, mes_fin,
        total_ingresos, total_gastos, total_ahorro,
        fecha_hora_creacion, estado,
        creado_por, creado_en
    )
    VALUES(
        p_id_usuario, p_nombre_presupuesto,
        p_anio_inicio, p_mes_inicio,
        p_anio_fin, p_mes_fin,
        p_total_ingresos, p_total_gastos, p_total_ahorro,
        NOW(), p_estado,
        p_creado_por, NOW()
    );
END //

-- UPDATE
CREATE PROCEDURE sp_presupuesto_update(
    IN p_id_presupuesto    INT,
    IN p_nombre_presupuesto VARCHAR(150),
    IN p_anio_inicio       INT,
    IN p_mes_inicio        INT,
    IN p_anio_fin          INT,
    IN p_mes_fin           INT,
    IN p_total_ingresos    DECIMAL(10,2),
    IN p_total_gastos      DECIMAL(10,2),
    IN p_total_ahorro      DECIMAL(10,2),
    IN p_estado            VARCHAR(50),
    IN p_modificado_por    VARCHAR(100)
)
BEGIN
    UPDATE presupuesto
    SET
        nombre_presupuesto = p_nombre_presupuesto,
        anio_inicio = p_anio_inicio,
        mes_inicio = p_mes_inicio,
        anio_fin = p_anio_fin,
        mes_fin = p_mes_fin,
        total_ingresos = p_total_ingresos,
        total_gastos = p_total_gastos,
        total_ahorro = p_total_ahorro,
        estado = p_estado,
        modificado_por = p_modificado_por,
        modificado_en = NOW()
    WHERE id_presupuesto = p_id_presupuesto;
END //

-- DELETE
CREATE PROCEDURE sp_presupuesto_delete(
    IN p_id_presupuesto INT
)
BEGIN
    DELETE FROM presupuesto
    WHERE id_presupuesto = p_id_presupuesto;
END //

-- GET
CREATE PROCEDURE sp_presupuesto_get(
    IN p_id_presupuesto INT
)
BEGIN
    SELECT *
    FROM presupuesto
    WHERE id_presupuesto = p_id_presupuesto;
END //

-- LIST
CREATE PROCEDURE sp_presupuesto_list()
BEGIN
    SELECT *
    FROM presupuesto;
END //

DELIMITER ;
