import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { CONFIG } from '../config.js';

export async function agregarDetallePresupuesto() {
  const idPresupuesto = await preguntar('ID Presupuesto: ');
  const idSubcategoria = await preguntar('ID Subcategoría: ');
  const monto = await preguntar('Monto mensual: ');
  const obs = await preguntar('Observaciones: ');

  await db.query(
    'CALL sp_insertar_presupuesto_detalle(?, ?, ?, ?, ?)',
    [idPresupuesto, idSubcategoria, monto, obs, CONFIG.CREADO_POR]
  );

  console.log('Detalle agregado');
}

