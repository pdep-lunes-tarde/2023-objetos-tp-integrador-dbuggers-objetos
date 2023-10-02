import carta.*
import mazoDeCartas.*
import wollok.game.*
import tp.*

object repartidor {
	const property mazoEnPartida = new List()
	const property mano = new List()
	var property sumaTotal = 0
	const property posY = 10
	var property posX = 5
	const property position = new Position(x=posX-3, y=posY)
	var property enJuego = false
	
	method repartirCartasIniciales() {
		self.darCarta(jugador)
		self.darCarta(jugador)
		self.darCarta(self)
		self.darCarta(self)
	}
	
	method sumaMano() = mano.sum({carta => carta.valor(self)})
	
	method darCarta(persona) {
		const cartaElegida = self.elegirCartaAleatorio()
		const suma = persona.sumaMano()
		persona.mano().add(cartaElegida)
		persona.sumaTotal(suma + cartaElegida.valor(self))
		cartaElegida.mostrar(persona)
	}
	
	method pedirCarta() {
		if (self.sumaMano() < 16 && enJuego) {
			self.darCarta(self)
			self.pedirCarta()
		}
		else {
			enJuego = false
			partida.terminarRonda()
		}
	}
	
	method llenarMazo() {
		mazoEnPartida.clear()
		mazoEnPartida.addAll(mazo.mazoLleno())
	}
	
	method elegirCartaAleatorio() {
		if (mazoEnPartida.isEmpty()) {
			self.llenarMazo()
		}
		const cartaElegida = mazoEnPartida.anyOne()
		mazoEnPartida.remove(cartaElegida)
		return cartaElegida
	}
	
	method sePaso() = self.sumaMano() > 21
	
	method text() = "Suma de cartas: " + self.sumaMano().toString()
	
	method textColor() = "FFFFFF"
	
	method esBlackjack() = self.sumaMano() == 21 && mano.size() == 2
}

object jugador {
	const property mano = new List()
	var property sumaTotal = 0
	const property posY = 3
	var property posX = 5
	const property position = new Position(x=posX-3, y=posY)
	var property enJuego = false
	
	method sumaMano() = mano.sum({carta => carta.valor(self)})
	
	method pedirCarta() {
		if (enJuego && not self.sePaso()) repartidor.darCarta(self)
		if (enJuego && self.sePaso()) self.finMano()
	}
	
	method sePaso() = self.sumaMano() > 21
	
	method plantarse() {
		self.finMano()
	}
	
	method finMano() {
		enJuego = false
		repartidor.pedirCarta()
	}
	
	method text() = "Suma de cartas: " + self.sumaMano().toString()
	
	method textColor() = "FFFFFF"
	
	method esBlackjack() = self.sumaMano() == 21 && mano.size() == 2
}


