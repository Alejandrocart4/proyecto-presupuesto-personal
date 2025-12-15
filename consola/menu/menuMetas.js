import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

export async function menuMetas() {
  titulo('Metas de Ahorro');

  console.log('1. Crear meta de ahorro');
  console.log('2. Actualizar meta');
  console.log('3. Cancelar meta');
  console.log('4. Consultar meta');
  console.log('5. Listar metas del usuario');
  console.log('0. Volver');

  return await preguntar('Opción: ');
}
