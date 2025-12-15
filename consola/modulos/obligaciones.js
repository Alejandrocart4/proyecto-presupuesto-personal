import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { CONFIG } from '../config.js';

export async function crearObligacion() {
  const idUsuario = await preguntar('ID Usuario: ');
  const idSubcategoria = await preguntar('ID Subcategoría: ');
  const nombre = await preguntar('Nombre obligación: ');
  const monto = await preguntar('Monto: ');
  const dia = await preguntar('Día vencimiento: ');
  const inicio = await preguntar('Fecha inicio (YYYY-MM-DD): ');

  await db.query(
    'CALL sp_insertar_obligacion(?, ?, ?, "", ?, ?, ?, NULL, ?)',
    [idUsuario, idSubcategoria, nombre, monto, dia, inicio, null, CONFIG.CREADO_POR]
  );

  console.log('Obligación creada');
}
