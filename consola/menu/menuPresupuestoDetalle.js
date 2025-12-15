import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

export async function menuPresupuestoDetalle() {
  titulo('Detalle del Presupuesto');

  console.log('1. Agregar subcategoría al presupuesto');
  console.log('2. Actualizar monto mensual');
  console.log('3. Eliminar detalle');
  console.log('4. Listar detalles del presupuesto');
  console.log('0. Volver');

  return await preguntar('Opción: ');
}
