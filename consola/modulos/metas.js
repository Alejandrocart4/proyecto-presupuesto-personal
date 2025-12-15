import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { CONFIG } from '../config.js';

export async function crearMeta() {
  const idUsuario = await preguntar('ID Usuario: ');
  const idSubcategoria = await preguntar('ID Subcategoría ahorro: ');
  const nombre = await preguntar('Nombre meta: ');
  const monto = await preguntar('Monto objetivo: ');
  const inicio = await preguntar('Fecha inicio: ');
  const fin = await preguntar('Fecha objetivo: ');

  await db.query(
    'CALL sp_insertar_meta(?, ?, ?, "", ?, ?, ?, "media", ?)',
    [idUsuario, idSubcategoria, nombre, monto, inicio, fin, CONFIG.CREADO_POR]
  );

  console.log('Meta creada');
}

