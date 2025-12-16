import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

import { agregarDetallePresupuesto } from '../modulos/presupuestodetalle.js';

export async function menuPresupuestoDetalle() {
  let continuar = true;

  while (continuar) {
    titulo('Detalle del Presupuesto');

    console.log('1. Agregar subcategoría al presupuesto');
    console.log('2. Actualizar monto mensual');
    console.log('3. Eliminar detalle');
    console.log('4. Listar detalles');
    console.log('0. Volver');

    const opcion = await preguntar('Opción: ');

    switch (opcion) {
      case '1':
        await agregarDetallePresupuesto();
        break;

      case '0':
        continuar = false;
        break;

      default:
        console.log('Opción inválida');
    }
  }
}
