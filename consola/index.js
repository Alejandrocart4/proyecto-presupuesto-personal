import { menuPrincipal } from './menu/menuPrincipal.js';

import { menuUsuarios } from './menu/menuUsuarios.js';
import { menuCategorias } from './menu/menuCategorias.js';
import { menuSubcategorias } from './menu/menuSubcategorias.js';
import { menuPresupuestos } from './menu/menuPresupuestos.js';
import { menuPresupuestoDetalle } from './menu/menuPresupuestoDetalle.js';
import { menuTransacciones } from './menu/menuTransacciones.js';
import { menuObligaciones } from './menu/menuObligaciones.js';
import { menuMetas } from './menu/menuMetas.js';
import { menuAlertas } from './menu/menuAlertas.js';
import { menuReportes } from './menu/menuReportes.js';

import * as usuarios from './modulos/usuarios.js';
import * as categorias from './modulos/categorias.js';
import * as subcategorias from './modulos/subcategorias.js';
import * as presupuestos from './modulos/presupuestos.js';
import * as presupuestoDetalle from './modulos/presupuestoDetalle.js';
import * as transacciones from './modulos/transacciones.js';
import * as obligaciones from './modulos/obligaciones.js';
import * as metas from './modulos/metas.js';
import * as alertas from './modulos/alertas.js';

import * as reportes from './reportes/balanceMensual.js';

async function gestionarUsuarios() {
  let op;
  do {
    op = await menuUsuarios();
    switch (op) {
      case '1': await usuarios.crearUsuario(); break;
      case '5': await usuarios.listarUsuarios(); break;
    }
  } while (op !== '0');
}

async function gestionarCategorias() {
  let op;
  do {
    op = await menuCategorias();
    switch (op) {
      case '1': await categorias.crearCategoria(); break;
      case '5': await categorias.listarCategorias(); break;
      case '6': await gestionarSubcategorias(); break;
    }
  } while (op !== '0');
}

async function gestionarSubcategorias() {
  let op;
  do {
    op = await menuSubcategorias();
    switch (op) {
      case '1': await subcategorias.crearSubcategoria(); break;
    }
  } while (op !== '0');
}

async function gestionarPresupuestos() {
  let op;
  do {
    op = await menuPresupuestos();
    switch (op) {
      case '1': await presupuestos.crearPresupuesto(); break;
      case '6': await gestionarPresupuestoDetalle(); break;
    }
  } while (op !== '0');
}

async function gestionarPresupuestoDetalle() {
  let op;
  do {
    op = await menuPresupuestoDetalle();
    switch (op) {
      case '1': await presupuestoDetalle.agregarDetallePresupuesto(); break;
    }
  } while (op !== '0');
}

async function gestionarTransacciones() {
  let op;
  do {
    op = await menuTransacciones();
    switch (op) {
      case '1': await transacciones.registrarTransaccion(); break;
    }
  } while (op !== '0');
}

async function gestionarObligaciones() {
  let op;
  do {
    op = await menuObligaciones();
    switch (op) {
      case '1': await obligaciones.crearObligacion(); break;
    }
  } while (op !== '0');
}

async function gestionarMetas() {
  let op;
  do {
    op = await menuMetas();
    switch (op) {
      case '1': await metas.crearMeta(); break;
    }
  } while (op !== '0');
}

async function gestionarAlertas() {
  let op;
  do {
    op = await menuAlertas();
    switch (op) {
      case '1': await alertas.listarAlertasNoLeidas(); break;
    }
  } while (op !== '0');
}

async function gestionarReportes() {
  let op;
  do {
    op = await menuReportes();
    switch (op) {
      case '1': await reportes.balanceMensual(); break;
    }
  } while (op !== '0');
}

async function main() {
  let opcion;
  do {
    opcion = await menuPrincipal();

    switch (opcion) {
      case '1': await gestionarUsuarios(); break;
      case '2': await gestionarCategorias(); break;
      case '3': await gestionarPresupuestos(); break;
      case '4': await gestionarTransacciones(); break;
      case '5': await gestionarObligaciones(); break;
      case '6': await gestionarMetas(); break;
      case '7': await gestionarAlertas(); break;
      case '8': await gestionarReportes(); break;
    }

  } while (opcion !== '0');

  console.log('Saliendo del sistema...');
  process.exit();
}

main();
