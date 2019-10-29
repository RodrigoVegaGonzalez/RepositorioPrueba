'use strict'

//Parametros REST Y SPREAD

function listadofrutas(fruta1, fruta2, ...restofrutas){
	console.log("Fruta 1:",fruta1)
	console.log("Fruta 2:",fruta2)
	console.log("El resto de frutas: ",restofrutas)
}


listadofrutas("Naranja","Pera","Manzana","Platano","Sandia","Limon")
var frutas = ['Naranja','Manzana']
listadofrutas("Naranja","Pera","Manzana","Platano","Sandia","Limon",...frutas)