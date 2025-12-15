import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

export async function balanceMensual() {
  titulo('Balance Mensual');

  const idUsuario = await preguntar('ID Usuario: ');
  const idPresupuesto = await preguntar('ID Presupuesto: ');
  const anio = await preguntar('Año: ');
  const mes = await preguntar('Mes: ');

  await db.query(
    'CALL sp_calcular_balance_mensual(?, ?, ?, ?, @ing, @gas, @aho, @bal)',
    [idUsuario, idPresupuesto, anio, mes]
  );

  const [result] = await db.query(`
    SELECT 
      @ing AS ingresos,
      @gas AS gastos,
      @aho AS ahorros,
      @bal AS balance_final
  `);

  console.table(result);
}
