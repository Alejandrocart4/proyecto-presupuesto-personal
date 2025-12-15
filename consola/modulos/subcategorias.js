import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { CONFIG } from '../config.js';

export async function crearSubcategoria() {
  const idCategoria = await preguntar('ID Categoría: ');
  const nombre = await preguntar('Nombre subcategoría: ');
  const descripcion = await preguntar('Descripción: ');

  await db.query(
    'CALL sp_insertar_subcategoria(?, ?, ?, 0, ?)',
    [idCategoria, nombre, descripcion, CONFIG.CREADO_POR]
  );

  console.log('Subcategoría creada');
}
