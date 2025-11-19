DELIMITER //

-- CREATE
CREATE PROCEDURE sp_transaccion_create(
    IN p_id_usuario         INT,
    IN p_id_presupuesto     INT,
    IN p_id_subcategoria    INT,
    IN p_id_obligacion_fija INT,
    IN p_tipo_transaccion   VARCHAR(50),
    IN p_descripcion        VARCHAR(255),
    IN p_monto              DECIMAL(10,2),
    IN p_fecha              DATE,
    IN p_metodo_pago        VARCHAR(100),
    IN p_numero_factura     VARCHAR(100),
    IN p_observaciones      VARCHAR(255),
    IN p_creado_por         VARCHAR(100)
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

-- UPDATE
CREATE PROCEDURE sp_transaccion_update(
    IN p_id_transaccion     INT,
    IN p_descripcion        VARCHAR(255),
    IN p_monto              DECIMAL(10,2),
    IN p_fecha              DATE,
    IN p_metodo_pago        VARCHAR(100),
    IN p_numero_factura     VARCHAR(100),
    IN p_observaciones      VARCHAR(255),
    IN p_modificado_por     VARCHAR(100)
)
BEGIN
    UPDATE transaccion
    SET
        descripcion = p_descripcion,
        monto = p_monto,
        fecha = p_fecha,
        metodo_pago = p_metodo_pago,
        numero_factura = p_numero_factura,
        observaciones = p_observaciones,
        modificado_por = p_modificado_por,
        modificado_en = NOW()
    WHERE id_transaccion = p_id_transaccion;
END //

-- DELETE
CREATE PROCEDURE sp_transaccion_delete(
    IN p_id_transaccion INT
)
BEGIN
    DELETE FROM transaccion
    WHERE id_transaccion = p_id_transaccion;
END //

-- GET
CREATE PROCEDURE sp_transaccion_get(
    IN p_id_transaccion INT
)
BEGIN
    SELECT *
    FROM transaccion
    WHERE id_transaccion = p_id_transaccion;
END //

-- LIST
CREATE PROCEDURE sp_transaccion_list()
BEGIN
    SELECT *
    FROM transaccion;
END //

DELIMITER ;

call sp_transaccion_list();
