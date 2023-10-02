import wollok.game.*

// ♣♥♠♦

class Carta {
	const property indice
	var property valor
	var property image = "./imagenes/cartas/carta.png"
	
	method valor(persona) = valor
}

class As {
	const property indice
	var property valor
	var property image = "./imagenes/cartas/carta.png"

	method valor(persona) {
		const suma = persona.sumaTotal()// Arreglo temporal
		if (suma > 21 && valor == 11) { 
			valor = 1
			persona.sumaTotal(suma-10)
		}
		return valor
	}
}


