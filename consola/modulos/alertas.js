import { db } from '../db.js';
import { preguntar } from '../util/input.js';

export async function listarAlertasNoLeidas() {
  const idUsuario = await preguntar('ID Usuario: ');
  const [rows] = await db.query(
    'CALL sp_listar_alertas_no_leidas(?)',
    [idUsuario]
  );

  console.table(rows[0]);
}
