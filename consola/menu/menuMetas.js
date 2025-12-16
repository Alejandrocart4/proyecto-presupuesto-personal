import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

import { crearMeta } from '../modulos/metas.js';

export async function menuMetas() {
  let continuar = true;

  while (continuar) {
    titulo('Metas de Ahorro');

    console.log('1. Crear meta');
    console.log('2. Actualizar meta');
    console.log('3. Cancelar meta');
    console.log('4. Consultar meta');
    console.log('5. Listar metas');
    console.log('0. Volver');

    const opcion = await preguntar('Opción: ');

    switch (opcion) {
      case '1':
        await crearMeta();
        break;

      case '0':
        continuar = false;
        break;

      default:
        console.log('Opción inválida');
    }
  }
}
