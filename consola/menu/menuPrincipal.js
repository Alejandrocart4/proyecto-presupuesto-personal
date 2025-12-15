import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

export async function menuPrincipal() {
  titulo('Sistema de Presupuesto Personal');

  console.log('1. Gestión de Usuarios');
  console.log('2. Gestión de Categorías');
  console.log('3. Gestión de Presupuestos');
  console.log('4. Transacciones');
  console.log('5. Obligaciones Fijas');
  console.log('6. Metas de Ahorro');
  console.log('7. Alertas');
  console.log('8. Reportes');
  console.log('0. Salir');

  return await preguntar('Seleccione una opción: ');
}
