import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

import { registrarTransaccion } from '../modulos/transacciones.js';

export async function menuTransacciones() {
  let continuar = true;

  while (continuar) {
    titulo('Gestión de Transacciones');

    console.log('1. Registrar transacción');
    console.log('2. Actualizar transacción');
    console.log('3. Eliminar transacción');
    console.log('4. Consultar transacción');
    console.log('5. Listar transacciones');
    console.log('0. Volver');

    const opcion = await preguntar('Opción: ');

    switch (opcion) {
      case '1':
        await registrarTransaccion();
        break;

      case '0':
        continuar = false;
        break;

      default:
        console.log('Opción inválida');
    }
  }
}
