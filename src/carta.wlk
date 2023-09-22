// ♣♥♠♦

import mazoDeCartas.*

object partida {
	const property mazoEnPartida = new List()
	
	method repartirCartasIniciales(jugador) {
		jugador.mano().add(new Carta(indice = "10♣", valor = 10))
		jugador.mano().add(new Carta(indice = "5♦", valor = 5))
	}
	
	method darCarta() {
		jugador.mano().add(new Carta(indice = "3♦", valor = 10))
	}
	
	method llenarMazo() {
		mazo.agregarCartas(self.mazoEnPartida())
	}
	
	method elegirCartaAleatorio() {
		if (self.mazoEnPartida().isEmpty()) {
			return 0
		}
		const indiceAleatorio = 0..self.mazoEnPartida().size()
		const cartaElegida = self.mazoEnPartida().get(indiceAleatorio.anyOne())
		self.mazoEnPartida().remove(cartaElegida)
		return cartaElegida
	}
	
}

object jugador {
	const property mano = new Set()
	
	method sumaMano() {
		return self.mano().sum({carta => carta.valor()})
	}
}

class Carta {
	const property indice
	const property valor
}

class As {
	const property indice
	const property valor = 1
	
	method valorEnPartida(jugador) {
		if (jugador.suma() == 0) {
			return 0
		} 
		return 1
	}
}


