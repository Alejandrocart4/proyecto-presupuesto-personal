import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

export async function menuSubcategorias() {
  titulo('Gestión de Subcategorías');

  console.log('1. Crear subcategoría');
  console.log('2. Actualizar subcategoría');
  console.log('3. Eliminar subcategoría');
  console.log('4. Consultar subcategoría');
  console.log('5. Listar subcategorías por categoría');
  console.log('0. Volver');

  return await preguntar('Opción: ');
}
