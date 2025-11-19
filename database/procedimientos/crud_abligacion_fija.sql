DELIMITER //

-- CREATE
CREATE PROCEDURE sp_obligacion_fija_create(
    IN p_id_usuario         INT,
    IN p_id_subcategoria    INT,
    IN p_nombre_obligacion  VARCHAR(150),
    IN p_descripcion        VARCHAR(255),
    IN p_monto_fijo         DECIMAL(10,2),
    IN p_dia_vencimiento    INT,
    IN p_estado             VARCHAR(50),
    IN p_fecha_inicio       DATE,
    IN p_fecha_finalizacion DATE,
    IN p_creado_por         VARCHAR(100)
)
BEGIN
    INSERT INTO obligacion_fija(
        id_usuario, id_subcategoria, nombre_obligacion,
        descripcion, monto_fijo_mensual, dia_vencimiento,
        estado, fecha_inicio, fecha_finalizacion,
        creado_por, creado_en
    )
    VALUES(
        p_id_usuario, p_id_subcategoria, p_nombre_obligacion,
        p_descripcion, p_monto_fijo, p_dia_vencimiento,
        p_estado, p_fecha_inicio, p_fecha_finalizacion,
        p_creado_por, NOW()
    );
END //

-- UPDATE
CREATE PROCEDURE sp_obligacion_fija_update(
    IN p_id_obligacion_fija INT,
    IN p_nombre_obligacion  VARCHAR(150),
    IN p_descripcion        VARCHAR(255),
    IN p_monto_fijo         DECIMAL(10,2),
    IN p_dia_vencimiento    INT,
    IN p_estado             VARCHAR(50),
    IN p_fecha_finalizacion DATE,
    IN p_modificado_por     VARCHAR(100)
)
BEGIN
    UPDATE obligacion_fija
    SET
        nombre_obligacion = p_nombre_obligacion,
        descripcion = p_descripcion,
        monto_fijo_mensual = p_monto_fijo,
        dia_vencimiento = p_dia_vencimiento,
        estado = p_estado,
        fecha_finalizacion = p_fecha_finalizacion,
        modificado_por = p_modificado_por,
        modificado_en = NOW()
    WHERE id_obligacion_fija = p_id_obligacion_fija;
END //

-- DELETE
CREATE PROCEDURE sp_obligacion_fija_delete(
    IN p_id_obligacion_fija INT
)
BEGIN
    DELETE FROM obligacion_fija
    WHERE id_obligacion_fija = p_id_obligacion_fija;
END //

-- GET
CREATE PROCEDURE sp_obligacion_fija_get(
    IN p_id_obligacion_fija INT
)
BEGIN
    SELECT *
    FROM obligacion_fija
    WHERE id_obligacion_fija = p_id_obligacion_fija;
END //

-- LIST
CREATE PROCEDURE sp_obligacion_fija_list()
BEGIN
    SELECT *
    FROM obligacion_fija;
END //

DELIMITER ;
