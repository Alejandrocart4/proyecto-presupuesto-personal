DELIMITER //

-- CREATE
CREATE PROCEDURE sp_subcategoria_create(
    IN p_id_categoria         INT,
    IN p_nombre_subcategoria  VARCHAR(100),
    IN p_estado               VARCHAR(50),
    IN p_auto                 TINYINT,
    IN p_creado_por           VARCHAR(100)
)
BEGIN
    INSERT INTO subcategoria(
        id_categoria, nombre_subcategoria, estado, auto,
        creado_por, creado_en
    )
    VALUES(
        p_id_categoria, p_nombre_subcategoria, p_estado, p_auto,
        p_creado_por, NOW()
    );
END //

-- UPDATE
CREATE PROCEDURE sp_subcategoria_update(
    IN p_id_subcategoria      INT,
    IN p_nombre_subcategoria  VARCHAR(100),
    IN p_estado               VARCHAR(50),
    IN p_auto                 TINYINT,
    IN p_modificado_por       VARCHAR(100)
)
BEGIN
    UPDATE subcategoria
    SET
        nombre_subcategoria = p_nombre_subcategoria,
        estado = p_estado,
        auto = p_auto,
        modificado_por = p_modificado_por,
        modificado_en = NOW()
    WHERE id_subcategoria = p_id_subcategoria;
END //

-- DELETE
CREATE PROCEDURE sp_subcategoria_delete(
    IN p_id_subcategoria INT
)
BEGIN
    DELETE FROM subcategoria
    WHERE id_subcategoria = p_id_subcategoria;
END //

-- GET
CREATE PROCEDURE sp_subcategoria_get(
    IN p_id_subcategoria INT
)
BEGIN
    SELECT *
    FROM subcategoria
    WHERE id_subcategoria = p_id_subcategoria;
END //

-- LIST
CREATE PROCEDURE sp_subcategoria_list()
BEGIN
    SELECT *
    FROM subcategoria;
END //

DELIMITER ;

call sp_subcategoria_list();
