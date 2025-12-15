import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

export async function menuObligaciones() {
  titulo('Obligaciones Fijas');

  console.log('1. Crear obligación');
  console.log('2. Actualizar obligación');
  console.log('3. Desactivar obligación');
  console.log('4. Consultar obligación');
  console.log('5. Listar obligaciones del usuario');
  console.log('0. Volver');

  return await preguntar('Opción: ');
}
