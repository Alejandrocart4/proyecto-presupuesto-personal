import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

import { balanceMensual } from '../modulos/reportes.js';

export async function menuReportes() {
  let continuar = true;

  while (continuar) {
    titulo('Reportes');

    console.log('1. Balance mensual');
    console.log('2. Ingresos vs Gastos vs Ahorro');
    console.log('3. Gastos por categoría');
    console.log('4. Cumplimiento de presupuesto');
    console.log('5. Progreso de metas');
    console.log('0. Volver');

    const opcion = await preguntar('Opción: ');

    switch (opcion) {
      case '1':
        await balanceMensual();
        break;

      case '0':
        continuar = false;
        break;

      default:
        console.log('Opción inválida');
    }
  }
}
