import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

export async function menuAlertas() {
  titulo('Alertas del Sistema');

  console.log('1. Ver alertas no leídas');
  console.log('2. Marcar alerta como leída');
  console.log('3. Consultar alerta');
  console.log('0. Volver');

  return await preguntar('Opción: ');
}
