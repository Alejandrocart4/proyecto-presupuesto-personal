import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { exito, error } from '../util/output.js';
import { CONFIG } from '../config.js';

export async function crearSubcategoria() {
  try {
    const idCategoria = await preguntar('ID Categoría: ');
    const nombre = await preguntar('Nombre: ');
    const estado = await preguntar('Estado: ');
    const auto = await preguntar('Auto (0/1): ');

    await db.query(
      'CALL sp_subcategoria_create(?,?,?,?,?)',
      [idCategoria, nombre, estado, auto, CONFIG.CREADO_POR]
    );

    exito('Subcategoría creada');
  } catch (err) {
    error(err.message);
  }
}

export async function actualizarSubcategoria() {
  try {
    const id = await preguntar('ID Subcategoría: ');
    const nombre = await preguntar('Nombre: ');
    const estado = await preguntar('Estado: ');
    const auto = await preguntar('Auto (0/1): ');

    await db.query(
      'CALL sp_subcategoria_update(?,?,?,?,?)',
      [id, nombre, estado, auto, CONFIG.CREADO_POR]
    );

    exito('Subcategoría actualizada');
  } catch (err) {
    error(err.message);
  }
}

export async function eliminarSubcategoria() {
  try {
    const id = await preguntar('ID Subcategoría: ');
    await db.query(
      'CALL sp_subcategoria_delete(?)',
      [id]
    );
    exito('Subcategoría eliminada');
  } catch (err) {
    error(err.message);
  }
}

export async function consultarSubcategoria() {
  try {
    const id = await preguntar('ID Subcategoría: ');
    const [rows] = await db.query(
      'CALL sp_subcategoria_get(?)',
      [id]
    );
    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}

export async function listarSubcategorias() {
  try {
    const [rows] = await db.query(
      'CALL sp_subcategoria_list()'
    );
    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}
