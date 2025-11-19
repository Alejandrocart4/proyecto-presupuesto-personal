DELIMITER //

-- CREATE
CREATE PROCEDURE sp_usuario_create(
    IN p_primer_nombre      VARCHAR(100),
    IN p_segundo_nombre     VARCHAR(100),
    IN p_primer_apellido    VARCHAR(100),
    IN p_segundo_apellido   VARCHAR(100),
    IN p_correo             VARCHAR(150),
    IN p_salario_mensual    DECIMAL(10,2),
    IN p_creado_por         VARCHAR(100)
)
BEGIN
    INSERT INTO usuario(
        primer_nombre, segundo_nombre, primer_apellido, segundo_apellido,
        correo, fecha_registro, salario_mensual_base, estado,
        creado_por, creado_en
    )
    VALUES(
        p_primer_nombre, p_segundo_nombre, p_primer_apellido, p_segundo_apellido,
        p_correo, NOW(), p_salario_mensual, 'activo',
        p_creado_por, NOW()
    );
END //

-- UPDATE
CREATE PROCEDURE sp_usuario_update(
    IN p_id_usuario         INT,
    IN p_primer_nombre      VARCHAR(100),
    IN p_segundo_nombre     VARCHAR(100),
    IN p_primer_apellido    VARCHAR(100),
    IN p_segundo_apellido   VARCHAR(100),
    IN p_correo             VARCHAR(150),
    IN p_salario_mensual    DECIMAL(10,2),
    IN p_modificado_por     VARCHAR(100)
)
BEGIN
    UPDATE usuario
    SET
        primer_nombre = p_primer_nombre,
        segundo_nombre = p_segundo_nombre,
        primer_apellido = p_primer_apellido,
        segundo_apellido = p_segundo_apellido,
        correo = p_correo,
        salario_mensual_base = p_salario_mensual,
        modificado_por = p_modificado_por,
        modificado_en = NOW()
    WHERE id_usuario = p_id_usuario;
END //

-- DELETE (LOGICO)
CREATE PROCEDURE sp_usuario_delete(
    IN p_id_usuario     INT,
    IN p_modificado_por VARCHAR(100)
)
BEGIN
    UPDATE usuario
    SET estado = 'inactivo',
        modificado_por = p_modificado_por,
        modificado_en = NOW()
    WHERE id_usuario = p_id_usuario;
END //

-- GET
CREATE PROCEDURE sp_usuario_get(
    IN p_id_usuario INT
)
BEGIN
    SELECT *
    FROM usuario
    WHERE id_usuario = p_id_usuario;
END //

CREATE PROCEDURE sp_usuario_list()
BEGIN
    SELECT *
    FROM usuario;
END //

DELIMITER ;

CALL sp_usuario_list();
