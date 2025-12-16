import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { exito, error } from '../util/output.js';
import { CONFIG } from '../config.js';

export async function registrarTransaccion() {
  try {
    const idUsuario = await preguntar('ID Usuario: ');
    const idPresupuesto = await preguntar('ID Presupuesto: ');
    const idSubcategoria = await preguntar('ID Subcategoría: ');
    const idObligacion = await preguntar('ID Obligación (opcional): ');
    const tipo = await preguntar('Tipo (ingreso/gasto/ahorro): ');
    const descripcion = await preguntar('Descripción: ');
    const monto = await preguntar('Monto: ');
    const fecha = await preguntar('Fecha (YYYY-MM-DD): ');
    const metodo = await preguntar('Método pago: ');
    const factura = await preguntar('Factura: ');
    const obs = await preguntar('Observaciones: ');

    await db.query(
      'CALL sp_transaccion_create(?,?,?,?,?,?,?,?,?,?,?,?,?)',
      [
        idUsuario,
        idPresupuesto,
        idSubcategoria,
        idObligacion || null,
        tipo,
        descripcion,
        monto,
        fecha,
        metodo,
        factura,
        obs,
        CONFIG.CREADO_POR
      ]
    );

    exito('Transacción registrada');
  } catch (err) {
    error(err.message);
  }
}

export async function actualizarTransaccion() {
  try {
    const id = await preguntar('ID Transacción: ');
    const descripcion = await preguntar('Descripción: ');
    const monto = await preguntar('Monto: ');
    const fecha = await preguntar('Fecha: ');
    const metodo = await preguntar('Método pago: ');
    const factura = await preguntar('Factura: ');
    const obs = await preguntar('Observaciones: ');

    await db.query(
      'CALL sp_transaccion_update(?,?,?,?,?,?,?,?)',
      [id, descripcion, monto, fecha, metodo, factura, obs, CONFIG.CREADO_POR]
    );

    exito('Transacción actualizada');
  } catch (err) {
    error(err.message);
  }
}

export async function eliminarTransaccion() {
  try {
    const id = await preguntar('ID Transacción: ');
    await db.query('CALL sp_transaccion_delete(?)', [id]);
    exito('Transacción eliminada');
  } catch (err) {
    error(err.message);
  }
}

export async function consultarTransaccion() {
  try {
    const id = await preguntar('ID Transacción: ');
    const [rows] = await db.query('CALL sp_transaccion_get(?)', [id]);
    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}

export async function listarTransacciones() {
  try {
    const [rows] = await db.query('CALL sp_transaccion_list()');
    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}
