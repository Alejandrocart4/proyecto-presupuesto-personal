import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

export async function menuTransacciones() {
  titulo('Gestión de Transacciones');

  console.log('1. Registrar transacción');
  console.log('2. Actualizar transacción');
  console.log('3. Eliminar transacción');
  console.log('4. Consultar transacción');
  console.log('5. Listar transacciones por mes');
  console.log('0. Volver');

  return await preguntar('Opción: ');
}
