import wollok.game.*

class Carta {
	const property indice
	var property valor
	const frente = "./imagenes/cartas/carta.png"
	const reverso = "./imagenes/cartas/back_side.png"
	var property image = frente
	
	method valor(persona) = valor
	
	method mostrar(persona) {
		const x = persona.posUltimaCarta()
		persona.posUltimaCarta(x+1)
		game.addVisualIn(self, game.at(x,persona.position().y())) // Arreglar el tema del pos
	}
	
	method darVuelta() {
		if (image == reverso) image = frente
		else image = reverso
	}
}

class As inherits Carta {

	override method valor(persona) { // Arreglar esto
		if (persona.sumaCartas() > 21 && valor == 11) { 
			valor = 1
		}
		return valor
	}
	
}
