import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

import {
  crearSubcategoria
} from '../modulos/subcategorias.js';

export async function menuSubcategorias() {
  let continuar = true;

  while (continuar) {
    titulo('Gestión de Subcategorías');

    console.log('1. Crear subcategoría');
    console.log('2. Actualizar subcategoría');
    console.log('3. Eliminar subcategoría');
    console.log('4. Consultar subcategoría');
    console.log('5. Listar subcategorías');
    console.log('0. Volver');

    const opcion = await preguntar('Opción: ');

    switch (opcion) {
      case '1':
        await crearSubcategoria();
        break;

      case '0':
        continuar = false;
        break;

      default:
        console.log('Opción inválida');
    }
  }
}
