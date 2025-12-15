import { db } from '../db.js';
import { preguntar } from '../util/input.js';
import { CONFIG } from '../config.js';

export async function registrarTransaccion() {
  const idUsuario = await preguntar('ID Usuario: ');
  const idPresupuesto = await preguntar('ID Presupuesto: ');
  const anio = await preguntar('Año: ');
  const mes = await preguntar('Mes: ');
  const idSubcategoria = await preguntar('ID Subcategoría: ');
  const tipo = await preguntar('Tipo (ingreso/gasto/ahorro): ');
  const descripcion = await preguntar('Descripción: ');
  const monto = await preguntar('Monto: ');
  const fecha = await preguntar('Fecha (YYYY-MM-DD): ');
  const metodo = await preguntar('Método pago: ');

  await db.query(
    'CALL sp_insertar_transaccion(?, ?, ?, ?, ?, NULL, ?, ?, ?, ?, ?, NULL, NULL, ?)',
    [
      idUsuario,
      idPresupuesto,
      anio,
      mes,
      idSubcategoria,
      tipo,
      descripcion,
      monto,
      fecha,
      metodo,
      CONFIG.CREADO_POR
    ]
  );

  console.log('Transacción registrada');
}
