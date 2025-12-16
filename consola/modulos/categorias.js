import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { exito, error } from '../util/output.js';
import { CONFIG } from '../config.js';

export async function crearCategoria() {
  try {
    const nombre = await preguntar('Nombre: ');
    const desc = await preguntar('Descripción: ');
    const tipo = await preguntar('Tipo: ');
    const icono = await preguntar('Icono: ');
    const color = await preguntar('Color hex: ');
    const orden = await preguntar('Orden: ');

    await db.query(
      'CALL sp_categoria_create(?,?,?,?,?,?,?)',
      [nombre, desc, tipo, icono, color, orden, CONFIG.CREADO_POR]
    );

    exito('Categoría creada');
  } catch (err) {
    error(err.message);
  }
}

export async function actualizarCategoria() {
  try {
    const id = await preguntar('ID Categoría: ');
    const nombre = await preguntar('Nombre: ');
    const desc = await preguntar('Descripción: ');
    const tipo = await preguntar('Tipo: ');
    const icono = await preguntar('Icono: ');
    const color = await preguntar('Color hex: ');
    const orden = await preguntar('Orden: ');

    await db.query(
      'CALL sp_categoria_update(?,?,?,?,?,?,?,?)',
      [id, nombre, desc, tipo, icono, color, orden, CONFIG.CREADO_POR]
    );

    exito('Categoría actualizada');
  } catch (err) {
    error(err.message);
  }
}

export async function eliminarCategoria() {
  try {
    const id = await preguntar('ID Categoría: ');
    await db.query(
      'CALL sp_categoria_delete(?)',
      [id]
    );
    exito('Categoría eliminada');
  } catch (err) {
    error(err.message);
  }
}

export async function consultarCategoria() {
  try {
    const id = await preguntar('ID Categoría: ');
    const [rows] = await db.query(
      'CALL sp_categoria_get(?)',
      [id]
    );
    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}

export async function listarCategorias() {
  try {
    const [rows] = await db.query(
      'CALL sp_categoria_list()'
    );
    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}
