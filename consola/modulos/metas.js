import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { exito, error } from '../util/output.js';
import { CONFIG } from '../config.js';

export async function crearMeta() {
  try {
    const idUsuario = await preguntar('ID Usuario: ');
    const idSubcategoria = await preguntar('ID Subcategoría: ');
    const nombre = await preguntar('Nombre meta: ');
    const descripcion = await preguntar('Descripción: ');
    const montoTotal = await preguntar('Monto total: ');
    const montoAhorrado = await preguntar('Monto ahorrado inicial: ');
    const fechaInicio = await preguntar('Fecha inicio (YYYY-MM-DD): ');
    const fechaObjetivo = await preguntar('Fecha objetivo (YYYY-MM-DD): ');
    const prioridad = await preguntar('Prioridad: ');
    const estado = await preguntar('Estado: ');

    await db.query(
      'CALL sp_meta_ahorro_create(?,?,?,?,?,?,?,?,?,?,?)',
      [
        idUsuario,
        idSubcategoria,
        nombre,
        descripcion,
        montoTotal,
        montoAhorrado,
        fechaInicio,
        fechaObjetivo,
        prioridad,
        estado,
        CONFIG.CREADO_POR
      ]
    );

    exito('Meta de ahorro creada');
  } catch (err) {
    error(err.message);
  }
}

export async function actualizarMeta() {
  try {
    const id = await preguntar('ID Meta: ');
    const nombre = await preguntar('Nombre: ');
    const descripcion = await preguntar('Descripción: ');
    const montoTotal = await preguntar('Monto total: ');
    const montoAhorrado = await preguntar('Monto ahorrado: ');
    const fechaObjetivo = await preguntar('Fecha objetivo: ');
    const prioridad = await preguntar('Prioridad: ');
    const estado = await preguntar('Estado: ');

    await db.query(
      'CALL sp_meta_ahorro_update(?,?,?,?,?,?,?,?)',
      [
        id,
        nombre,
        descripcion,
        montoTotal,
        montoAhorrado,
        fechaObjetivo,
        prioridad,
        estado,
        CONFIG.CREADO_POR
      ]
    );

    exito('Meta actualizada');
  } catch (err) {
    error(err.message);
  }
}

export async function eliminarMeta() {
  try {
    const id = await preguntar('ID Meta: ');
    await db.query('CALL sp_meta_ahorro_delete(?)', [id]);
    exito('Meta eliminada');
  } catch (err) {
    error(err.message);
  }
}

export async function consultarMeta() {
  try {
    const id = await preguntar('ID Meta: ');
    const [rows] = await db.query('CALL sp_meta_ahorro_get(?)', [id]);
    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}

export async function listarMetas() {
  try {
    const [rows] = await db.query('CALL sp_meta_ahorro_list()');
    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}
