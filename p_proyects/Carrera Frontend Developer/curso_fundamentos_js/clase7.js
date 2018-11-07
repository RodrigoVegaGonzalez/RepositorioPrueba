var sacha = {
  nombre: 'sacha',
  apellido: 'lifszyc',
  edad: 28
}

var dario = {
  nombre: 'Dario',
  apellido: 'susnisky',
  edad: 27
}

var victor = {
  nombre: 'Victor Hugo',
  apellido: 'Morales Martinez',
  edad: 19
}
 function imprimirNombreEnMayusculas(persona){
   //var nombre= persona.nombre//
   var {nombre} = persona
   console.log(nombre.toUpperCase())
 }

imprimirNombreEnMayusculas(sacha)
imprimirNombreEnMayusculas(dario)
//imprimirNombreEnMayusculas({nombre : 'pepe'})//

function imprimirNombreyEdad(persona){
  var{nombre} = persona
  var {edad} = persona
  console.log('Hola me llamo '+nombre.toUpperCase()+ ' y tengo ' +edad+ ' años')
}

imprimirNombreyEdad(sacha)
imprimirNombreyEdad(dario)
imprimirNombreyEdad(victor)
