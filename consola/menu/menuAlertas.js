import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

import { listarAlertasNoLeidas } from '../modulos/alertas.js';

export async function menuAlertas() {
  let continuar = true;

  while (continuar) {
    titulo('Alertas del Sistema');

    console.log('1. Ver alertas no leídas');
    console.log('2. Marcar alerta como leída');
    console.log('3. Consultar alerta');
    console.log('0. Volver');

    const opcion = await preguntar('Opción: ');

    switch (opcion) {
      case '1':
        await listarAlertasNoLeidas();
        break;

      case '0':
        continuar = false;
        break;

      default:
        console.log('Opción inválida');
    }
  }
}
