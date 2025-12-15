import { preguntar } from '../util/input.js';
import { titulo } from '../util/output.js';

import {
  crearUsuario,
  actualizarUsuario,
  desactivarUsuario,
  consultarUsuario,
  listarUsuarios
} from '../modulos/usuarios.js';

/**
 * Menú de gestión de usuarios (consola)
 */
export async function menuUsuarios() {
  let continuar = true;

  while (continuar) {
    titulo('Gestión de Usuarios');

    console.log('1. Crear usuario');
    console.log('2. Actualizar usuario');
    console.log('3. Desactivar usuario');
    console.log('4. Consultar usuario');
    console.log('5. Listar usuarios');
    console.log('0. Volver');

    const opcion = await preguntar('Opción: ');

    switch (opcion) {
      case '1':
        await crearUsuario();
        break;

      case '2':
        await actualizarUsuario();
        break;

      case '3':
        await desactivarUsuario();
        break;

      case '4':
        await consultarUsuario();
        break;

      case '5':
        await listarUsuarios();
        break;

      case '0':
        continuar = false;
        break;

      default:
        console.log('Opción inválida');
    }
  }
}
