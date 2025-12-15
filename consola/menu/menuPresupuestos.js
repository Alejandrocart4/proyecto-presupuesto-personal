import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

export async function menuPresupuestos() {
  titulo('Gestión de Presupuestos');

  console.log('1. Crear presupuesto');
  console.log('2. Actualizar presupuesto');
  console.log('3. Cerrar presupuesto');
  console.log('4. Consultar presupuesto');
  console.log('5. Listar presupuestos por usuario');
  console.log('6. Detalle de presupuesto');
  console.log('0. Volver');

  return await preguntar('Opción: ');
}
