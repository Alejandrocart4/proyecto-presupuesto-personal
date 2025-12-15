import mysql from 'mysql2/promise';

export const db = await mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'cartagena65',
  database: 'presupuesto_personal',
  waitForConnections: true,
  connectionLimit: 10
});
