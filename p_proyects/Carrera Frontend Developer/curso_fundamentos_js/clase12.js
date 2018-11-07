var sasha = {
  nombre: 'Sacha',
  apellido: 'Lifszyc',
  edad: 28,
  ingeniero: true,
  cocinero: false,
  cantante: false,
  dj: false,
  guitarrista: false,
  drones: true
}
var victor = {
  nombre: 'Victor',
  apellido: 'M. Martinez',
  edad: 19,
  ingeniero: true,
  cocinero: true,
  cantante: true,
  dj: true,
  guitarrista: true,
  drones: true
}
var leonardo = {
  nombre: 'Leonardo',
  apellido: 'M. Martinez',
  edad: 11,
  ingeniero: true,
  cocinero: true,
  cantante: true,
  dj: true,
  guitarrista: true,
  drones: true
}

const MAYORIA_DE_EDAD = 18


function imprimirProfeciones(persona){
  console.log(`${persona.nombre} ${persona.apellido} es: `)

  if(persona.ingeniero === true){
    console.log('Ingeniero')
  } else {
    console.log('no es ingeniero');
  }
  if (persona.cocinero === true){
    console.log('Cocinero')
  }
  if(persona.cantante === true){
    console.log('Cantante')
  }
  if (persona.dj === true){
    console.log('DJ')
  }
  if(persona.guitarrista === true){
    console.log('Guitarrista')
  }
  if (persona.drones === true){
    console.log('Vuela Drones')
  }
}

// var esMayorDeEdad = function (persona){
//   return persona.edad >= MAYORIA_DE_EDAD
// }
const esMayorDeEdad = persona => persona.edad >= MAYORIA_DE_EDAD

var esMenorDeEdad = persona =>{
if (!esMayorDeEdad(persona)) {
  console.log('si, si es menor de edad');
}else {
  console.log('es mayor de edad');
}}

function imprimirSiEsMayorDeEdad(persona){
  if (esMayorDeEdad(persona)) {
    console.log(`${persona.nombre} ${persona.apellido} es mayor de edad `)
  }else {
    console.log(`${persona.nombre} ${persona.apellido} es menor de edad `);
  }
}

function permitirAcceso(persona){
  if (!esMayorDeEdad(persona)) {
    console.log('ACCESO DENEGADO');
  }else {
    console.log('ACCESO CONCEDIDO');
  }
}
