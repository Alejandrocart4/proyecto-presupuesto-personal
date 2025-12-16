import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { exito, error } from '../util/output.js';
import { CONFIG } from '../config.js';

export async function agregarDetallePresupuesto() {
  try {
    const idPresupuesto = await preguntar('ID Presupuesto: ');
    const idSubcategoria = await preguntar('ID Subcategoría: ');
    const monto = await preguntar('Monto mensual: ');
    const obs = await preguntar('Observación: ');

    await db.query(
      'CALL sp_presupuesto_detalle_create(?,?,?,?,?)',
      [idPresupuesto, idSubcategoria, monto, obs, CONFIG.CREADO_POR]
    );

    exito('Detalle agregado');
  } catch (err) {
    error(err.message);
  }
}

export async function actualizarDetallePresupuesto() {
  try {
    const id = await preguntar('ID Detalle: ');
    const monto = await preguntar('Monto mensual: ');
    const obs = await preguntar('Observación: ');

    await db.query(
      'CALL sp_presupuesto_detalle_update(?,?,?,?)',
      [id, monto, obs, CONFIG.CREADO_POR]
    );

    exito('Detalle actualizado');
  } catch (err) {
    error(err.message);
  }
}

export async function eliminarDetallePresupuesto() {
  try {
    const id = await preguntar('ID Detalle: ');
    await db.query('CALL sp_presupuesto_detalle_delete(?)', [id]);
    exito('Detalle eliminado');
  } catch (err) {
    error(err.message);
  }
}

export async function listarDetallePresupuesto() {
  try {
    const [rows] = await db.query('CALL sp_presupuesto_detalle_list()');
    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}
