import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

import { crearPresupuesto } from '../modulos/presupuestos.js';
import { menuPresupuestoDetalle } from './menuPresupuestoDetalle.js';

export async function menuPresupuestos() {
  let continuar = true;

  while (continuar) {
    titulo('Gestión de Presupuestos');

    console.log('1. Crear presupuesto');
    console.log('2. Actualizar presupuesto');
    console.log('3. Cerrar presupuesto');
    console.log('4. Consultar presupuesto');
    console.log('5. Listar presupuestos');
    console.log('6. Detalle de presupuesto');
    console.log('0. Volver');

    const opcion = await preguntar('Opción: ');

    switch (opcion) {
      case '1':
        await crearPresupuesto();
        break;

      case '6':
        await menuPresupuestoDetalle();
        break;

      case '0':
        continuar = false;
        break;

      default:
        console.log('Opción inválida');
    }
  }
}
