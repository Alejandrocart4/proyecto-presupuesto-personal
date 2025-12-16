import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { exito, error } from '../util/output.js';

/**
 * 1. Listar alertas no leídas
 */
export async function listarAlertasNoLeidas() {
  try {
    const idUsuario = await preguntar('ID Usuario: ');
    const [rows] = await db.query(
      'CALL sp_listar_alertas_no_leidas(?)',
      [idUsuario]
    );
    console.table(rows[0]);
  } catch (err) {
    error(err.message);
  }
}

/**
 * 2. Marcar alerta como leída
 */
export async function marcarAlertaLeida() {
  try {
    const idAlerta = await preguntar('ID Alerta: ');
    await db.query(
      'UPDATE alerta SET vista = 1 WHERE id_alerta = ?',
      [idAlerta]
    );
    exito('Alerta marcada como leída');
  } catch (err) {
    error(err.message);
  }
}

/**
 * 3. Consultar alerta
 */
export async function consultarAlerta() {
  try {
    const idAlerta = await preguntar('ID Alerta: ');
    const [rows] = await db.query(
      'SELECT * FROM alerta WHERE id_alerta = ?',
      [idAlerta]
    );
    console.table(rows);
  } catch (err) {
    error(err.message);
  }
}
