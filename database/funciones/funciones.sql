DELIMITER //

/* ============================================================
   1. fn_monto_ejecutado_subcategoria
   Parámetros:
      p_id_subcategoria INT
      p_anio INT
      p_mes INT
   Retorna:
      DECIMAL(10,2) → Total ejecutado
   ============================================================ */
CREATE FUNCTION fn_monto_ejecutado_subcategoria(
    p_id_subcategoria INT,
    p_anio INT,
    p_mes INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_ejecutado DECIMAL(10,2);

    SELECT SUM(monto) INTO v_ejecutado
    FROM transaccion
    WHERE id_subcategoria = p_id_subcategoria
      AND YEAR(fecha) = p_anio
      AND MONTH(fecha) = p_mes;

    RETURN IFNULL(v_ejecutado, 0);
END //

/* ============================================================
   2. fn_presupuesto_mensual
   Parámetros:
      p_id_presupuesto INT
      p_id_subcategoria INT
   Retorna:
      DECIMAL(10,2) → Monto mensual presupuestado
   ============================================================ */
CREATE FUNCTION fn_presupuesto_mensual(
    p_id_presupuesto INT,
    p_id_subcategoria INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_monto DECIMAL(10,2);

    SELECT monto_mensual INTO v_monto
    FROM presupuesto_detalle
    WHERE id_presupuesto = p_id_presupuesto
      AND id_subcategoria = p_id_subcategoria;

    RETURN IFNULL(v_monto, 0);
END //

/* ============================================================
   3. fn_porcentaje_ejecucion
   Parámetros:
      p_ejecutado DECIMAL(10,2)
      p_presupuesto DECIMAL(10,2)
   Retorna:
      DECIMAL(10,2) → porcentaje
   ============================================================ */
CREATE FUNCTION fn_porcentaje_ejecucion(
    p_ejecutado DECIMAL(10,2),
    p_presupuesto DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    IF p_presupuesto = 0 THEN
        RETURN 0;
    END IF;

    RETURN (p_ejecutado / p_presupuesto) * 100;
END //

/* ============================================================
   4. fn_obtener_categoria_por_sub
   Parámetros:
      p_id_subcategoria INT
   Retorna:
      INT → id_categoria
   ============================================================ */
CREATE FUNCTION fn_obtener_categoria_por_sub(
    p_id_subcategoria INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_categoria INT;

    SELECT id_categoria INTO v_categoria
    FROM subcategoria
    WHERE id_subcategoria = p_id_subcategoria;

    RETURN v_categoria;
END //

/* ============================================================
   5. fn_es_mes_vigente
   Parámetros:
      p_anio INT
      p_mes INT
   Retorna:
      TINYINT(1) → 1 si es vigente, 0 si no
   ============================================================ */
CREATE FUNCTION fn_es_mes_vigente(
    p_anio INT,
    p_mes INT
)
RETURNS TINYINT
DETERMINISTIC
BEGIN
    IF p_anio = YEAR(CURDATE()) AND p_mes = MONTH(CURDATE()) THEN
        RETURN 1;
    END IF;
    RETURN 0;
END //

/* ============================================================
   6. fn_dias_restantes_meta
   Parámetros:
      p_fecha_objetivo DATE
   Retorna:
      INT → días restantes
   ============================================================ */
CREATE FUNCTION fn_dias_restantes_meta(
    p_fecha_objetivo DATE
)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN DATEDIFF(p_fecha_objetivo, CURDATE());
END //

/* ============================================================
   7. fn_total_ingresos_mes
   Parámetros:
      p_id_usuario INT
      p_anio INT
      p_mes INT
   Retorna:
      DECIMAL(10,2)
   ============================================================ */
CREATE FUNCTION fn_total_ingresos_mes(
    p_id_usuario INT,
    p_anio INT,
    p_mes INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT SUM(monto) INTO v_total
    FROM transaccion
    WHERE id_usuario = p_id_usuario
      AND tipo_transaccion = 'ingreso'
      AND YEAR(fecha) = p_anio
      AND MONTH(fecha) = p_mes;

    RETURN IFNULL(v_total, 0);
END //

/* ============================================================
   8. fn_total_gastos_mes
   Parámetros:
      p_id_usuario INT
      p_anio INT
      p_mes INT
   Retorna:
      DECIMAL(10,2)
   ============================================================ */
CREATE FUNCTION fn_total_gastos_mes(
    p_id_usuario INT,
    p_anio INT,
    p_mes INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT SUM(monto) INTO v_total
    FROM transaccion
    WHERE id_usuario = p_id_usuario
      AND tipo_transaccion = 'gasto'
      AND YEAR(fecha) = p_anio
      AND MONTH(fecha) = p_mes;

    RETURN IFNULL(v_total, 0);
END //

/* ============================================================
   9. fn_total_ahorro_usuario
   Parámetros:
      p_id_usuario INT
   Retorna:
      DECIMAL(10,2)
   ============================================================ */
CREATE FUNCTION fn_total_ahorro_usuario(
    p_id_usuario INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT SUM(monto_ahorrado) INTO v_total
    FROM meta_ahorro
    WHERE id_usuario = p_id_usuario;

    RETURN IFNULL(v_total, 0);
END //

/* ============================================================
   10. fn_promedio_gasto_subcategoria
   Parámetros:
      p_id_subcategoria INT
   Retorna:
      DECIMAL(10,2)
   ============================================================ */
CREATE FUNCTION fn_promedio_gasto_subcategoria(
    p_id_subcategoria INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_promedio DECIMAL(10,2);

    SELECT AVG(monto) INTO v_promedio
    FROM transaccion
    WHERE id_subcategoria = p_id_subcategoria
      AND tipo_transaccion = 'gasto';

    RETURN IFNULL(v_promedio, 0);
END //

/* ============================================================
   11. fn_suma_presupuesto_categoria
   Parámetros:
      p_id_categoria INT
   Retorna:
      DECIMAL(10,2)
   ============================================================ */
CREATE FUNCTION fn_suma_presupuesto_categoria(
    p_id_categoria INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT SUM(pd.monto_mensual) INTO v_total
    FROM presupuesto_detalle pd
    JOIN subcategoria sc ON sc.id_subcategoria = pd.id_subcategoria
    WHERE sc.id_categoria = p_id_categoria;

    RETURN IFNULL(v_total, 0);
END //

/* ============================================================
   12. fn_mes_nombre
   Parámetros:
      p_mes INT
   Retorna:
      VARCHAR(15)
   ============================================================ */
CREATE FUNCTION fn_mes_nombre(
    p_mes INT
)
RETURNS VARCHAR(15)
DETERMINISTIC
BEGIN
    RETURN ELT(p_mes, 'Enero','Febrero','Marzo','Abril','Mayo','Junio',
               'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre');
END //

DELIMITER ;

