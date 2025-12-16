import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { exito, error } from '../util/output.js';
import { CONFIG } from '../config.js';

export async function crearObligacion() {
  try {
    const idUsuario = await preguntar('ID Usuario: ');
    const idSubcategoria = await preguntar('ID Subcategoría: ');
    const nombre = await preguntar('Nombre: ');
    const descripcion = await preguntar('Descripción: ');
    const monto = await preguntar('Monto mensual: ');
    const dia = await preguntar('Día vencimiento: ');
    const estado = await preguntar('Estado: ');
    const inicio = await preguntar('Fecha inicio: ');
    const fin = await preguntar('Fecha fin (opcional): ');

    await db.query(
      'CALL sp_obligacion_fija_create(?,?,?,?,?,?,?,?,?,?)',
      [
        idUsuario,
        idSubcategoria,
        nombre,
        descripcion,
        monto,
        dia,
        estado,
        inicio,
        fin || null,
        CONFIG.CREADO_POR
      ]
    );

    exito('Obligación creada');
  } catch (err) {
    error(err.message);
  }
}

export async function actualizarObligacion() {
  try {
    const id = await preguntar('ID Obligación: ');
    const nombre = await preguntar('Nombre: ');
    const descripcion = await preguntar('Descripción: ');
    const monto = await preguntar('Monto mensual: ');
    const dia = await preguntar('Día vencimiento: ');
    const estado = await preguntar('Estado: ');
    const fin = await preguntar('Fecha fin: ');

    await db.query(
      'CALL sp_obligacion_fija_update(?,?,?,?,?,?,?,?)',
      [id, nombre, descripcion, monto, dia, estado, fin, CONFIG.CREADO_POR]
    );

    exito('Obligación actualizada');
  } catch (err) {
    error(err.message);
  }
}

export async function eliminarObligacion() {
  try {
    const id = await preguntar('ID Obligación: ');
    await db.query('CALL sp_obligacion_fija_delete(?)', [id]);
    exito('Obligación eliminada');
  } catch (err) {
    error(err.message);
  }
}

export async function consultarObligacion() {
  try {
    const id = await preguntar('ID Obligación: ');
    const [rows] = await db.query('CALL sp_obligacion_fija_get(?)', [id]);
    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}

export async function listarObligaciones() {
  try {
    const [rows] = await db.query('CALL sp_obligacion_fija_list()');
    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}
