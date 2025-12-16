import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { exito, error } from '../util/output.js';
import { CONFIG } from '../config.js';

export async function crearPresupuesto() {
  try {
    const idUsuario = await preguntar('ID Usuario: ');
    const nombre = await preguntar('Nombre: ');
    const anioIni = await preguntar('Año inicio: ');
    const mesIni = await preguntar('Mes inicio: ');
    const anioFin = await preguntar('Año fin: ');
    const mesFin = await preguntar('Mes fin: ');
    const estado = await preguntar('Estado: ');

    await db.query(
      'CALL sp_presupuesto_create(?,?,?,?,?,?,?,?,?,?,?)',
      [
        idUsuario,
        nombre,
        anioIni,
        mesIni,
        anioFin,
        mesFin,
        0,
        0,
        0,
        estado,
        CONFIG.CREADO_POR
      ]
    );

    exito('Presupuesto creado');
  } catch (err) {
    error(err.message);
  }
}

export async function actualizarPresupuesto() {
  try {
    const id = await preguntar('ID Presupuesto: ');
    const nombre = await preguntar('Nombre: ');
    const anioIni = await preguntar('Año inicio: ');
    const mesIni = await preguntar('Mes inicio: ');
    const anioFin = await preguntar('Año fin: ');
    const mesFin = await preguntar('Mes fin: ');
    const ingresos = await preguntar('Total ingresos: ');
    const gastos = await preguntar('Total gastos: ');
    const ahorro = await preguntar('Total ahorro: ');
    const estado = await preguntar('Estado: ');

    await db.query(
      'CALL sp_presupuesto_update(?,?,?,?,?,?,?,?,?,?,?)',
      [
        id,
        nombre,
        anioIni,
        mesIni,
        anioFin,
        mesFin,
        ingresos,
        gastos,
        ahorro,
        estado,
        CONFIG.CREADO_POR
      ]
    );

    exito('Presupuesto actualizado');
  } catch (err) {
    error(err.message);
  }
}

export async function cerrarPresupuesto() {
  try {
    const id = await preguntar('ID Presupuesto: ');
    await db.query(
      'CALL sp_cerrar_presupuesto(?,?)',
      [id, CONFIG.CREADO_POR]
    );
    exito('Presupuesto cerrado');
  } catch (err) {
    error(err.message);
  }
}

export async function consultarPresupuesto() {
  try {
    const id = await preguntar('ID Presupuesto: ');
    const [rows] = await db.query('CALL sp_presupuesto_get(?)', [id]);
    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}

export async function listarPresupuestos() {
  try {
    const [rows] = await db.query('CALL sp_presupuesto_list()');
    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}
