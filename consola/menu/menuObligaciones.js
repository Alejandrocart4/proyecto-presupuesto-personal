import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

import { crearObligacion } from '../modulos/obligaciones.js';

export async function menuObligaciones() {
  let continuar = true;

  while (continuar) {
    titulo('Obligaciones Fijas');

    console.log('1. Crear obligación');
    console.log('2. Actualizar obligación');
    console.log('3. Desactivar obligación');
    console.log('4. Consultar obligación');
    console.log('5. Listar obligaciones');
    console.log('0. Volver');

    const opcion = await preguntar('Opción: ');

    switch (opcion) {
      case '1':
        await crearObligacion();
        break;

      case '0':
        continuar = false;
        break;

      default:
        console.log('Opción inválida');
    }
  }
}
