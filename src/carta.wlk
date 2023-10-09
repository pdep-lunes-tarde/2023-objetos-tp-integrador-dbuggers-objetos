import wollok.game.*

class Carta {
	const property indice
	var property valor
	const frente = "./imagenes/cartas/carta.png"
	const reverso = "./imagenes/cartas/back_side.png"
	var property image = frente
	
	method valor(persona) = valor
	
	method mostrar(persona) {
		const x = persona.posX()
		persona.posX(x+1)
		game.addVisualIn(self, game.at(x,persona.posY())) // Arreglar el tema del pos
	}
	
	method darVuelta() {
		if (image == reverso) image = frente
		else image = reverso
	}
}

class As inherits Carta {

	override method valor(persona) {
		const suma = persona.sumaTotal() // Arreglar esto
		if (suma > 21 && valor == 11) { 
			valor = 1
			persona.sumaTotal(suma-10)
		}
		return valor
	}
}


