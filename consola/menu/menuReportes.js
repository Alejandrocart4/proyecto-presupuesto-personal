import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

export async function menuReportes() {
  titulo('Reportes');

  console.log('1. Balance mensual');
  console.log('2. Ingresos vs Gastos vs Ahorro');
  console.log('3. Gastos por categoría');
  console.log('4. Cumplimiento de presupuesto');
  console.log('5. Progreso de metas de ahorro');
  console.log('0. Volver');

  return await preguntar('Opción: ');
}
