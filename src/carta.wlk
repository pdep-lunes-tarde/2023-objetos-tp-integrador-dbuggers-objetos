// ♣♥♠♦

import mazoDeCartas.*

object repartidor {
	const property mazoEnPartida = new List()
	const property mano = new Set()
	
	method repartirCartasIniciales() {
		jugador.mano().add(self.elegirCartaAleatorio())
		jugador.mano().add(self.elegirCartaAleatorio())
		mano.add(self.elegirCartaAleatorio())
		mano.add(self.elegirCartaAleatorio())
	}
	
	method sumaMano() {
		return mano.sum({carta => carta.valor()})
	}
	
	method darCarta(persona) {
		persona.mano().add(self.elegirCartaAleatorio())
	}
	
	method llenarMazo() {
		mazoEnPartida.clear()
		mazo.mazoLleno(mazoEnPartida)
	}
	
	method elegirCartaAleatorio() {
		if (mazoEnPartida.isEmpty()) {
			self.llenarMazo()
		}
		const indiceAleatorio = 0..mazoEnPartida.size()
		const cartaElegida = mazoEnPartida.get(indiceAleatorio.anyOne())
		mazoEnPartida.remove(cartaElegida)
		return cartaElegida
	}
	
	method sePaso() {
		return self.sumaMano() > 21
	}
}

object jugador {
	const property mano = new Set()
	
	method sumaMano() {
		return mano.sum({carta => carta.valor()})
	}
	
	method pedirCarta() {
		repartidor.darCarta(self)
	}
	
	method sePaso() {
		return self.sumaMano() > 21
	}
}

class Carta {
	const property indice
	const property valor
}

class As {
	const property indice
	
	method valor(persona) {
		if (persona.sePaso()) {
			return 1
		} 
		return 11
	}
}


