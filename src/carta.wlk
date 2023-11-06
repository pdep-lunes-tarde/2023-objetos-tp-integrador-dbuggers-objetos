import wollok.game.*

class Carta {
	const property indice
	const property valor
	const frente = "./imagenes/cartas/carta.png"
	const reverso = "./imagenes/cartas/back_side.png"
	var property image = frente

	method mostrar(persona) {
		const x = persona.posUltimaCarta()
		persona.posUltimaCarta(x+1)
		game.addVisualIn(self, game.at(x,persona.position().y()-1)) // Arreglar el tema del pos
	}
	
	method darVuelta() {
		if (image == reverso) image = frente
		else image = reverso
	}
	
}
