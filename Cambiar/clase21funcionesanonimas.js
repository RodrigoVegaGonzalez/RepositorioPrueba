'use strict'

//Es una funcion que no tiene nombre

var pelicula = function(nombre){
	return "La pelicula es"+nombre
}

// Un callback es una funcion que llama a otra funcion 


	function sumame(numero1, numero2,sumaymuesta,suapordos){
		var sumar = numero1 + numero2

		sumaymuesta(sumar)
		suapordos(sumar)
		return sumar
	}

	sumame(4,5,function(dato){
			console.log("La suma es: ",dato)
	}, dato => {
		console.log("La suma por dos es",dato*2)
	})




