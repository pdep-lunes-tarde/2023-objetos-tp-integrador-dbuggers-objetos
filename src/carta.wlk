import wollok.game.*

// ♣♥♠♦

class Carta {
	const property indice
	var property valor
	var property image = "./imagenes/cartas/carta.png"
	var property position = new Position()
	
	method valor(persona) = valor
	
	method mostrar(persona) {
		const x = persona.posX()
		persona.posX(x+2)
		position = game.at(x,persona.posY())
		game.addVisualIn(self, position)
	}
	
	method text() = "Carta: " + indice
	
	method textColor() = "FF0000FF"
}

class As inherits Carta {

	override method valor(persona) {
		const suma = persona.sumaTotal()// Arreglo temporal
		if (suma > 21 && valor == 11) { 
			valor = 1
			persona.sumaTotal(suma-10)
		}
		return valor
	}
}


