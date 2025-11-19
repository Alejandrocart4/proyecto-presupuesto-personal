DELIMITER //

-- CREATE
CREATE PROCEDURE sp_categoria_create(
    IN p_nombre_categoria        VARCHAR(100),
    IN p_descripcion_categoria   VARCHAR(255),
    IN p_tipo_categoria          VARCHAR(100),
    IN p_nombre_icono            VARCHAR(100),
    IN p_color_hex               VARCHAR(10),
    IN p_orden                   INT,
    IN p_creado_por              VARCHAR(100)
)
BEGIN
    INSERT INTO categoria(
        nombre_categoria, descripcion_categoria, tipo_categoria,
        nombre_iconoui_categoria, colorhexa_categoria, orden,
        creado_por, creado_en
    )
    VALUES(
        p_nombre_categoria, p_descripcion_categoria, p_tipo_categoria,
        p_nombre_icono, p_color_hex, p_orden,
        p_creado_por, NOW()
    );
END //

-- UPDATE
CREATE PROCEDURE sp_categoria_update(
    IN p_id_categoria            INT,
    IN p_nombre_categoria        VARCHAR(100),
    IN p_descripcion_categoria   VARCHAR(255),
    IN p_tipo_categoria          VARCHAR(100),
    IN p_nombre_icono            VARCHAR(100),
    IN p_color_hex               VARCHAR(10),
    IN p_orden                   INT,
    IN p_modificado_por          VARCHAR(100)
)
BEGIN
    UPDATE categoria
    SET
        nombre_categoria = p_nombre_categoria,
        descripcion_categoria = p_descripcion_categoria,
        tipo_categoria = p_tipo_categoria,
        nombre_iconoui_categoria = p_nombre_icono,
        colorhexa_categoria = p_color_hex,
        orden = p_orden,
        modificado_por = p_modificado_por,
        modificado_en = NOW()
    WHERE id_categoria = p_id_categoria;
END //

-- DELETE (eliminación lógica NO aplica porque no existe columna 'estado'")
-- por lo tanto, se hace eliminación física.
CREATE PROCEDURE sp_categoria_delete(
    IN p_id_categoria INT
)
BEGIN
    DELETE FROM categoria
    WHERE id_categoria = p_id_categoria;
END //

-- GET
CREATE PROCEDURE sp_categoria_get(
    IN p_id_categoria INT
)
BEGIN
    SELECT *
    FROM categoria
    WHERE id_categoria = p_id_categoria;
END //

-- LIST
CREATE PROCEDURE sp_categoria_list()
BEGIN
    SELECT *
    FROM categoria;
END //

DELIMITER ;
 
call sp_categoria_list();