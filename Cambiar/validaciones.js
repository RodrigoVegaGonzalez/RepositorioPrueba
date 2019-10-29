//var cadena = prompt("Ingresa alguna oracion","Rodrigo Vega")

'use strict'
var i
var tamano
var parrafo
var result
var cadena_array
var textoresultado

parrafo = document.getElementById("txtparrafo")
textoresultado = document.querySelector("#resultado")


			

			function ingresar(){
				parrafo = document.getElementById("txtparrafo").value.toString()
					cambiarletras(parrafo)
			}





function cambiarletras(parrafo){

			cadena_array = parrafo.split("")
			tamano = cadena_array.length
					for(i=0; i<tamano; i++){
				if(cadena_array[i]=='a' || cadena_array[i]=='e' || cadena_array[i]=='o' || cadena_array[i]=='u'   ){
					cadena_array[i]= 'i'
			} else if(cadena_array[i]=='A' || cadena_array[i]=='E' || cadena_array[i]=='O' || cadena_array[i]=='U'   ){
				cadena_array[i]= 'I'
			}
		}

			result = cadena_array.join('')

				console.log(result)
			result = document.getElementById('resultado').innerHTML = result

	//Se le pasa la letra y se cambia 
}



		function copiar(){
				var texto = document.querySelector("#resultado").value
				texto.select()
				document.execCommand('copy')

		}


		var limpia = document.querySelector('#btnLimpiar')
		limpia.addEventListener('click',function(){
			parrafo = document.getElementById("txtparrafo").value = " "
			result = document.getElementById('resultado').innerHTML = ""
		})

		
			function limpiar(){
				
				
				//parrafo.innerHTML = '';

				//resultado.

			}
//.pop elminina el ultimo elemento del array
//Para convertir un array a texto se usa "join"

//Para cambiar estilos desde js es con la etiqueta .style
//Para añadir clases a html es con la etiqueta .classname= 'Algo '
// caja = document.querySelector('#micaja') id 
// caja = document.querySelector('.micaja') clase
