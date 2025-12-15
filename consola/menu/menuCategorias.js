import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

export async function menuCategorias() {
  titulo('Gestión de Categorías');

  console.log('1. Crear categoría');
  console.log('2. Actualizar categoría');
  console.log('3. Eliminar categoría');
  console.log('4. Consultar categoría');
  console.log('5. Listar categorías');
  console.log('6. Subcategorías');
  console.log('0. Volver');

  return await preguntar('Opción: ');
}
