DELIMITER //

CREATE TRIGGER trg_categoria_crear_subcategoria
AFTER INSERT ON categoria
FOR EACH ROW
BEGIN
    INSERT INTO subcategoria (
        id_categoria,
        nombre_categoria,
        es_defecto,
        activa,
        creado_por,
        creado_en
    )
    VALUES (
        NEW.id_categoria,
        'General',
        1,
        1,
        NEW.creado_por,
        NOW()
    );
END;
//

DELIMITER ;
CREATE DEFINER=`root`@`localhost`
TRIGGER trg_actualizar_meta_ahorro
AFTER INSERT ON transaccion
FOR EACH ROW
BEGIN
    DECLARE v_tipo_categoria VARCHAR(100);
    DECLARE v_id_meta INT;

    -- Obtener el tipo real de la categoría
    SELECT c.tipo_categoria
    INTO v_tipo_categoria
    FROM subcategoria sc
    INNER JOIN categoria c 
        ON sc.id_categoria = c.id_categoria
    WHERE sc.id_subcategoria = NEW.id_subcategoria
    LIMIT 1;

    -- Si la categoría es de ahorro
    IF v_tipo_categoria = 'ahorro' THEN

        SELECT id_meta_ahorro
        INTO v_id_meta
        FROM meta_ahorro
        WHERE id_subcategoria = NEW.id_subcategoria
          AND estado = 'en_progreso'
        LIMIT 1;

        IF v_id_meta IS NOT NULL THEN
            UPDATE meta_ahorro
            SET monto_ahorrado = monto_ahorrado + NEW.monto
            WHERE id_meta_ahorro = v_id_meta;
        END IF;

    END IF;
END;

DELIMITER //

CREATE TRIGGER trg_alerta_presupuesto
AFTER INSERT ON transaccion
FOR EACH ROW
BEGIN
    DECLARE v_presupuestado DECIMAL(10,2);
    DECLARE v_ejecutado DECIMAL(10,2);
    DECLARE v_porcentaje DECIMAL(5,2);
    DECLARE v_tipo_categoria VARCHAR(20);

    -- Obtener tipo desde categoría padre
    SELECT c.tipo
    INTO v_tipo_categoria
    FROM subcategoria sc
    INNER JOIN categoria c ON sc.id_categoria = c.id_categoria
    WHERE sc.id_subcategoria = NEW.id_subcategoria;

    -- Solo aplica a gastos
    IF v_tipo_categoria = 'gasto' THEN

        SELECT monto_mensual
        INTO v_presupuestado
        FROM presupuesto_detalle
        WHERE id_presupuesto = NEW.id_presupuesto
          AND id_subcategoria = NEW.id_subcategoria
        LIMIT 1;

        SELECT SUM(monto)
        INTO v_ejecutado
        FROM transaccion
        WHERE id_presupuesto = NEW.id_presupuesto
          AND id_subcategoria = NEW.id_subcategoria;

        IF v_presupuestado IS NOT NULL AND v_ejecutado IS NOT NULL THEN
            SET v_porcentaje = (v_ejecutado / v_presupuestado) * 100;

            IF v_porcentaje >= 80 AND v_porcentaje < 100 THEN
                INSERT INTO alerta (id_usuario, tipo, prioridad, mensaje, creado_en, vista)
                VALUES (
                    NEW.id_usuario,
                    'presupuesto_80',
                    'advertencia',
                    CONCAT('Has alcanzado el 80% del presupuesto en la subcategoría ', NEW.id_subcategoria),
                    NOW(),
                    0
                );

            ELSEIF v_porcentaje >= 100 AND v_porcentaje < 120 THEN
                INSERT INTO alerta (id_usuario, tipo, prioridad, mensaje, creado_en, vista)
                VALUES (
                    NEW.id_usuario,
                    'presupuesto_100',
                    'critica',
                    CONCAT('Has alcanzado el 100% del presupuesto en la subcategoría ', NEW.id_subcategoria),
                    NOW(),
                    0
                );

            ELSEIF v_porcentaje >= 120 THEN
                INSERT INTO alerta (id_usuario, tipo, prioridad, mensaje, creado_en, vista)
                VALUES (
                    NEW.id_usuario,
                    'presupuesto_excedido',
                    'critica',
                    CONCAT('Has excedido el presupuesto en la subcategoría ', NEW.id_subcategoria),
                    NOW(),
                    0
                );
            END IF;

        END IF;
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_alerta_meta_ahorro
AFTER UPDATE ON meta_ahorro
FOR EACH ROW
BEGIN
    DECLARE v_porcentaje DECIMAL(5,2);

    -- Calcular porcentaje de avance
    SET v_porcentaje = (NEW.monto_ahorrado / NEW.monto_total) * 100;

    -- Alerta cuando alcanza el 50%
    IF v_porcentaje >= 50
       AND (OLD.monto_ahorrado / OLD.monto_total) * 100 < 50 THEN

        INSERT INTO alerta (
            id_usuario,
            tipo,
            prioridad,
            mensaje,
            creado_en,
            vista
        )
        VALUES (
            NEW.id_usuario,
            'meta_50',
            'informativa',
            CONCAT('Has alcanzado el 50% de la meta: ', NEW.nombre),
            NOW(),
            0
        );
    END IF;

    -- Cuando se completa la meta (100%)
    IF v_porcentaje >= 100
       AND OLD.estado <> 'completada' THEN

        UPDATE meta_ahorro
        SET estado = 'completada'
        WHERE id_meta_ahorro = NEW.id_meta_ahorro;

        INSERT INTO alerta (
            id_usuario,
            tipo,
            prioridad,
            mensaje,
            creado_en,
            vista
        )
        VALUES (
            NEW.id_usuario,
            'meta_completada',
            'informativa',
            CONCAT('Meta completada: ', NEW.nombre),
            NOW(),
            0
        );
    END IF;

END;
//

DELIMITER ;


