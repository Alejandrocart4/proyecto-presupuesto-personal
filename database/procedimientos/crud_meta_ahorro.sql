DELIMITER //

-- CREATE
CREATE PROCEDURE sp_meta_ahorro_create(
    IN p_id_usuario        INT,
    IN p_id_subcategoria   INT,
    IN p_nombre            VARCHAR(150),
    IN p_descripcion       VARCHAR(255),
    IN p_monto_total       DECIMAL(10,2),
    IN p_monto_ahorrado    DECIMAL(10,2),
    IN p_fecha_inicio      DATE,
    IN p_fecha_objetivo    DATE,
    IN p_prioridad         INT,
    IN p_estado            VARCHAR(50),
    IN p_creado_por        VARCHAR(100)
)
BEGIN
    INSERT INTO meta_ahorro(
        id_usuario, id_subcategoria, nombre, descripcion,
        monto_total, monto_ahorrado, fecha_inicio, fecha_objetivo,
        prioridad, estado, creado_por, creado_en
    )
    VALUES(
        p_id_usuario, p_id_subcategoria, p_nombre, p_descripcion,
        p_monto_total, p_monto_ahorrado, p_fecha_inicio, p_fecha_objetivo,
        p_prioridad, p_estado, p_creado_por, NOW()
    );
END //

-- UPDATE
CREATE PROCEDURE sp_meta_ahorro_update(
    IN p_id_meta_ahorro    INT,
    IN p_nombre            VARCHAR(150),
    IN p_descripcion       VARCHAR(255),
    IN p_monto_total       DECIMAL(10,2),
    IN p_monto_ahorrado    DECIMAL(10,2),
    IN p_fecha_objetivo    DATE,
    IN p_prioridad         INT,
    IN p_estado            VARCHAR(50),
    IN p_modificado_por    VARCHAR(100)
)
BEGIN
    UPDATE meta_ahorro
    SET
        nombre = p_nombre,
        descripcion = p_descripcion,
        monto_total = p_monto_total,
        monto_ahorrado = p_monto_ahorrado,
        fecha_objetivo = p_fecha_objetivo,
        prioridad = p_prioridad,
        estado = p_estado,
        modificado_por = p_modificado_por,
        modificado_en = NOW()
    WHERE id_meta_ahorro = p_id_meta_ahorro;
END //

-- DELETE
CREATE PROCEDURE sp_meta_ahorro_delete(
    IN p_id_meta_ahorro INT
)
BEGIN
    DELETE FROM meta_ahorro
    WHERE id_meta_ahorro = p_id_meta_ahorro;
END //

-- GET
CREATE PROCEDURE sp_meta_ahorro_get(
    IN p_id_meta_ahorro INT
)
BEGIN
    SELECT *
    FROM meta_ahorro
    WHERE id_meta_ahorro = p_id_meta_ahorro;
END //

-- LIST
CREATE PROCEDURE sp_meta_ahorro_list()
BEGIN
    SELECT *
    FROM meta_ahorro;
END //

DELIMITER ;
