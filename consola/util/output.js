export function titulo(texto) {
  console.log('\n==============================');
  console.log(texto.toUpperCase());
  console.log('==============================');
}

export function error(msg) {
  console.log(`ERROR: ${msg}`);
}

export function exito(msg) {
  console.log(`OK: ${msg}`);
}