var victor = {
  nombre: 'Victor',
  segundo_nombre: 'Hugo',
  edad: 19,
  peso: 69.9
}

console.log(`Al inicio de año ${victor.nombre} ${victor.segudo_nombre} pesa
  ${victor.peso} kg`)

const INCREMENTO_PESO = 0.300
const DIAS_AÑO = 365
const aumentarDePeso = persona  => persona.peso += INCREMENTO_PESO
const adelgazarDePeso = persona  => persona.peso -= INCREMENTO_PESO

const comeMucho = () => Math.random() < 0.3
const realizaDeporte = () => Math.random() <0.4
const META = victor.peso - 3

var dias = 0

while (victor.peso > META) {
  if (comeMucho()) {
    //aumentarDePeso
    aumentarDePeso(victor)
  }
  if(realizaDeporte()){
    //adelgazarDePeso
    adelgazarDePeso(victor)
  }
  dias+= 1
}
  console.log(`al final del año ${victor.nombre} ${victor.segundo_nombre} pesa
    ${victor.peso.toFixed(1)} kg`)
console.log(`Pasaron ${dias} Dias hasta que ${victor.nombre} adelgazo 3kg`);
