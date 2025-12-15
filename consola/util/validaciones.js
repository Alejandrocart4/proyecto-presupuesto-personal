/**
 * VALIDACIONES BÁSICAS DE ENTRADA
 * --------------------------------
 * Este archivo SOLO valida datos ingresados por el usuario
 * desde la consola. No contiene lógica de negocio.
 */

/**
 * Valida que el valor no esté vacío
 */
export function requerido(valor, nombreCampo = 'campo') {
  if (valor === undefined || valor === null || valor.toString().trim() === '') {
    throw new Error(`El ${nombreCampo} es obligatorio.`);
  }
  return valor;
}

/**
 * Valida que sea un número válido
 */
export function esNumero(valor, nombreCampo = 'campo') {
  if (isNaN(valor)) {
    throw new Error(`El ${nombreCampo} debe ser numérico.`);
  }
  return Number(valor);
}

/**
 * Valida números positivos (> 0)
 */
export function esPositivo(valor, nombreCampo = 'campo') {
  const numero = esNumero(valor, nombreCampo);
  if (numero <= 0) {
    throw new Error(`El ${nombreCampo} debe ser mayor que cero.`);
  }
  return numero;
}

/**
 * Valida un año (ej: 2024)
 */
export function validarAnio(valor) {
  const anio = esNumero(valor, 'año');
  if (anio < 2000 || anio > 2100) {
    throw new Error('El año ingresado no es válido.');
  }
  return anio;
}

/**
 * Valida un mes (1–12)
 */
export function validarMes(valor) {
  const mes = esNumero(valor, 'mes');
  if (mes < 1 || mes > 12) {
    throw new Error('El mes debe estar entre 1 y 12.');
  }
  return mes;
}

/**
 * Valida formato de fecha simple YYYY-MM-DD
 */
export function validarFecha(fecha) {
  const regex = /^\d{4}-\d{2}-\d{2}$/;
  if (!regex.test(fecha)) {
    throw new Error('La fecha debe tener formato YYYY-MM-DD.');
  }
  return fecha;
}

/**
 * Valida opciones de menú
 */
export function validarOpcion(opcion, opcionesValidas = []) {
  if (!opcionesValidas.includes(opcion)) {
    throw new Error('Opción inválida.');
  }
  return opcion;
}
