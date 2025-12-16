import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

import {
  crearCategoria,
  listarCategorias
} from '../modulos/categorias.js';

import { menuSubcategorias } from './menuSubcategorias.js';

export async function menuCategorias() {
  let continuar = true;

  while (continuar) {
    titulo('Gestión de Categorías');

    console.log('1. Crear categoría');
    console.log('2. Actualizar categoría');
    console.log('3. Eliminar categoría');
    console.log('4. Consultar categoría');
    console.log('5. Listar categorías');
    console.log('6. Subcategorías');
    console.log('0. Volver');

    const opcion = await preguntar('Opción: ');

    switch (opcion) {
      case '1':
        await crearCategoria();
        break;

      case '5':
        await listarCategorias();
        break;

      case '6':
        await menuSubcategorias();
        break;

      case '0':
        continuar = false;
        break;

      default:
        console.log('Opción inválida');
    }
  }
}
