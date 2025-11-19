DELIMITER //

-- CREATE
CREATE PROCEDURE sp_presupuesto_detalle_create(
    IN p_id_presupuesto     INT,
    IN p_id_subcategoria    INT,
    IN p_monto_mensual      DECIMAL(10,2),
    IN p_observacion        VARCHAR(255),
    IN p_creado_por         VARCHAR(100)
)
BEGIN
    INSERT INTO presupuesto_detalle(
        id_presupuesto, id_subcategoria, monto_mensual,
        observacion, creado_por, creado_en
    )
    VALUES(
        p_id_presupuesto, p_id_subcategoria, p_monto_mensual,
        p_observacion, p_creado_por, NOW()
    );
END //

-- UPDATE
CREATE PROCEDURE sp_presupuesto_detalle_update(
    IN p_id_presupuesto_detalle  INT,
    IN p_monto_mensual           DECIMAL(10,2),
    IN p_observacion             VARCHAR(255),
    IN p_modificado_por          VARCHAR(100)
)
BEGIN
    UPDATE presupuesto_detalle
    SET
        monto_mensual = p_monto_mensual,
        observacion = p_observacion,
        modificado_por = p_modificado_por,
        modificado_en = NOW()
    WHERE id_presupuesto_detalle = p_id_presupuesto_detalle;
END //

-- DELETE
CREATE PROCEDURE sp_presupuesto_detalle_delete(
    IN p_id_presupuesto_detalle INT
)
BEGIN
    DELETE FROM presupuesto_detalle
    WHERE id_presupuesto_detalle = p_id_presupuesto_detalle;
END //

-- GET
CREATE PROCEDURE sp_presupuesto_detalle_get(
    IN p_id_presupuesto_detalle INT
)
BEGIN
    SELECT *
    FROM presupuesto_detalle
    WHERE id_presupuesto_detalle = p_id_presupuesto_detalle;
END //

-- LIST
CREATE PROCEDURE sp_presupuesto_detalle_list()
BEGIN
    SELECT *
    FROM presupuesto_detalle;
END //

DELIMITER ;

call sp_presupuesto_detalle_list();
