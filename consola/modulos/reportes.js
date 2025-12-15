import { db } from '../db.js';
import { preguntar } from '../util/input.js';

export async function balanceMensual() {
  const idUsuario = await preguntar('ID Usuario: ');
  const idPresupuesto = await preguntar('ID Presupuesto: ');
  const anio = await preguntar('Año: ');
  const mes = await preguntar('Mes: ');

  const [rows] = await db.query(
    'CALL sp_calcular_balance_mensual(?, ?, ?, ?, @i, @g, @a, @b)',
    [idUsuario, idPresupuesto, anio, mes]
  );

  const [result] = await db.query(
    'SELECT @i ingresos, @g gastos, @a ahorros, @b balance'
  );

  console.table(result);
}
