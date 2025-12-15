
import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { CONFIG } from '../config.js';

export async function crearCategoria() {
  const nombre = await preguntar('Nombre categoría: ');
  const descripcion = await preguntar('Descripción: ');
  const tipo = await preguntar('Tipo (ingreso/gasto/ahorro): ');
  const idUsuario = await preguntar('ID Usuario: ');

  await db.query(
    'CALL sp_insertar_categoria(?, ?, ?, ?, ?)',
    [nombre, descripcion, tipo, idUsuario, CONFIG.CREADO_POR]
  );

  console.log('Categoría creada');
}

export async function listarCategorias() {
  const idUsuario = await preguntar('ID Usuario: ');
  const tipo = await preguntar('Tipo (opcional): ');

  const [rows] = await db.query(
    'CALL sp_listar_categorias(?, ?)',
    [idUsuario, tipo || null]
  );

  console.table(rows[0]);
}
