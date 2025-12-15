import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { exito, error } from '../util/output.js';
import { CONFIG } from '../config.js';
import { requerido, esPositivo } from '../util/validaciones.js';

export async function crearUsuario() {
  try {
    const primerNombre = requerido(await preguntar('Nombre: '), 'nombre');
    const primerApellido = requerido(await preguntar('Apellido: '), 'apellido');
    const email = requerido(await preguntar('Email: '), 'email');
    const salario = esPositivo(
      await preguntar('Salario mensual: '),
      'salario mensual'
    );

    await db.query(
      'CALL sp_usuario_create(?, ?, ?, ?, ?, ?, ?)',
      [
        primerNombre,
        null,                 
        primerApellido,
        null,                 
        email,
        salario,
        CONFIG.CREADO_POR
      ]
    );

    exito('Usuario creado correctamente');
  } catch (err) {
    error(err.message);
  }
}

export async function actualizarUsuario() {
  try {
    const id = requerido(await preguntar('ID del usuario: '), 'id usuario');
    const primerNombre = requerido(await preguntar('Nombre: '), 'nombre');
    const primerApellido = requerido(await preguntar('Apellido: '), 'apellido');
    const email = requerido(await preguntar('Email: '), 'email');
    const salario = esPositivo(
      await preguntar('Salario mensual: '),
      'salario mensual'
    );

    await db.query(
      'CALL sp_usuario_update(?, ?, ?, ?, ?, ?, ?, ?)',
      [
        id,
        primerNombre,
        null,              
        primerApellido,
        null,             
        email,
        salario,
        CONFIG.CREADO_POR
      ]
    );

    exito('Usuario actualizado correctamente');
  } catch (err) {
    error(err.message);
  }
}

export async function desactivarUsuario() {
  try {
    const id = requerido(await preguntar('ID del usuario: '), 'id usuario');

    await db.query(
      'CALL sp_usuario_delete(?, ?)',
      [id, CONFIG.CREADO_POR]
    );

    exito('Usuario desactivado correctamente');
  } catch (err) {
    error(err.message);
  }
}
export async function consultarUsuario() {
  try {
    const id = requerido(await preguntar('ID del usuario: '), 'id usuario');

    const [rows] = await db.query(
      'CALL sp_usuario_get(?)',
      [id]
    );

    if (rows[0].length === 0) {
      throw new Error('Usuario no encontrado');
    }

    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}

export async function listarUsuarios() {
  try {
    const [rows] = await db.query(
      'CALL sp_usuario_list()'
    );

    if (rows[0].length === 0) {
      console.log('No hay usuarios registrados');
      return;
    }

    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}

