import carta.*
import mazoDeCartas.*
import wollok.game.*
import tp.*

class Jugador {
	const property mano = new List()
	var property sumaTotal = 0
	const property posY
	var property posX = 5
	const property position = new Position(x=posX-3, y=posY)
	var property enJuego = false
	
	method sumaMano() = mano.sum({carta => carta.valor(self)})
	
	method sePaso() = self.sumaMano() > 21
	
	method text() = "Suma de cartas: " + self.sumaMano().toString()
	
	method textColor() = "FFFFFF"
	
	method esBlackjack() = self.sumaMano() == 21 && mano.size() == 2
	
	method finMano() {
		enJuego = false
	}
	
	method plantarse() {
		self.finMano()
	}
	
	method pedirCarta()
}

object repartidor inherits Jugador(posY = 10) {
	const property mazoEnPartida = new List()
	
	method repartirCartasIniciales() {
		self.darCarta(jugador)
		self.darCarta(jugador)
		self.darCarta(self)
		self.darCarta(self)
	}
	
	method darCarta(persona) {
		const cartaElegida = self.elegirCartaAleatorio()
		const suma = persona.sumaMano()
		persona.mano().add(cartaElegida)
		persona.sumaTotal(suma + cartaElegida.valor(self))
		cartaElegida.mostrar(persona)
	}
	
	override method pedirCarta() {
		if (self.sumaMano() < 16 && enJuego) {
			self.darCarta(self)
			self.pedirCarta()
		}
		else self.finMano()
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
	
	override method finMano() {
		super()
		partida.terminarRonda()
	}
}

object jugador inherits Jugador(posY = 3) {
	
	override method pedirCarta() {
		if (enJuego && not self.sePaso()) repartidor.darCarta(self)
		if (enJuego && self.sePaso()) self.finMano()
	}
	
	override method finMano() {
		super()
		repartidor.pedirCarta()
	}
}


