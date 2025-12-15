import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { CONFIG } from '../config.js';

export async function crearPresupuesto() {
  const idUsuario = await preguntar('ID Usuario: ');
  const nombre = await preguntar('Nombre presupuesto: ');
  const descripcion = await preguntar('Descripción: ');
  const inicio = await preguntar('Periodo inicio (YYYY-MM): ');
  const fin = await preguntar('Periodo fin (YYYY-MM): ');

  await db.query(
    'CALL sp_insertar_presupuesto(?, ?, ?, ?, ?, ?)',
    [idUsuario, nombre, descripcion, inicio, fin, CONFIG.CREADO_POR]
  );

  console.log('Presupuesto creado');
}
