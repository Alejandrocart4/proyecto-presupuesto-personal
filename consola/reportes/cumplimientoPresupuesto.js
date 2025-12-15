import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

export async function cumplimientoPresupuesto() {
  titulo('Cumplimiento de Presupuesto');

  const idPresupuesto = await preguntar('ID Presupuesto: ');
  const anio = await preguntar('Año: ');
  const mes = await preguntar('Mes: ');

  const [rows] = await db.query(`
    SELECT
      c.nombre AS categoria,
      sc.nombre AS subcategoria,
      pd.monto_mensual AS presupuestado,
      IFNULL(SUM(t.monto), 0) AS ejecutado,
      ROUND((IFNULL(SUM(t.monto),0) / pd.monto_mensual) * 100, 2) AS porcentaje
    FROM presupuesto_detalle pd
    INNER JOIN subcategoria sc ON pd.id_subcategoria = sc.id_subcategoria
    INNER JOIN categoria c ON sc.id_categoria = c.id_categoria
    LEFT JOIN transaccion t
      ON t.id_subcategoria = sc.id_subcategoria
     AND t.anio = ?
     AND t.mes = ?
    WHERE pd.id_presupuesto = ?
    GROUP BY c.nombre, sc.nombre, pd.monto_mensual
    ORDER BY porcentaje DESC
  `, [anio, mes, idPresupuesto]);

  console.table(rows);
}
