var victor = {
  nombre: 'Victor',
  segundo_nombre: 'Hugo',
  edad: 19,
  peso: 69.9
}

console.log(`Al inicio de año ${victor.nombre} ${victor.segudo_nombre} pesa
  ${victor.peso} kg`)

const INCREMENTO_PESO = 0.200
const aumentarDePeso = persona  => persona.peso += INCREMENTO_PESO
const adelgazarDePeso = persona  => persona.peso -= INCREMENTO_PESO

  for(var i = 1; i <= 365 ; i++) {
    var random = Math.random()
    if(random<0.25){
      aumentarDePeso(victor)
    } else if (random <0.5){
      adelgazarDePeso(victor)
    }
  }

  console.log(`al final del año ${victor.nombre} ${victor.segudo_nombre} pesa
    ${victor.peso.toFixed(1)} kg`)
