import { db } from './db.js';

async function probarUsuarioTabla() {
  try {
    const [rows] = await db.query(
      'SELECT id_usuario, primer_nombre, correo FROM USUARIO LIMIT 2'
    );

    if (rows.length === 0) {
      console.log('CONEXIÓN OK, pero no hay usuarios registrados');
    } else {
      console.log('USUARIOS ENCONTRADOS:');
      console.table(rows);
    }

    process.exit();
  } catch (error) {
    console.error('ERROR AL CONSULTAR USUARIOS');
    console.error(error.message);
    process.exit(1);
  }
}

probarUsuarioTabla();