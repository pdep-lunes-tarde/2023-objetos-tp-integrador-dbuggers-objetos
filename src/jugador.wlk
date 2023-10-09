import carta.*
import mazoDeCartas.*
import wollok.game.*
import tp.*

class Jugador {
	const property mano = new List()
	var property sumaTotal = 0
	const property posY // Modificar esto
	var property posX
	const property position = new Position(x=posX-3, y=posY)
	var property enJuego = false
	
	method sumaMano() = 
		mano.sum({carta => carta.valor(self)}) // Modificar esto
	
	method sePaso() = self.sumaMano() > 21
	
	method text() = "Suma de cartas: " + self.sumaMano().toString()
	
	method textColor() = "FFFFFF"
	
	method esBlackjack() = self.sumaMano() == 21 && mano.size() == 2
	
	method finTurno() {
		enJuego = false
	}
	
	method pedirCarta()
}

object repartidor inherits Jugador(posY = 10, posX = 5) {
	const property mazoEnPartida = new List()
	
	method repartirCartasIniciales() {
		2.times({i => self.darCarta(self) })
		2.times({i => self.darCarta(jugador) })
		self.darVueltaPrimerCarta()
	}
	
	method darCarta(persona) {
		const cartaElegida = self.elegirCartaAleatorio()
		const suma = persona.sumaMano() // ...
		persona.mano().add(cartaElegida)
		persona.sumaTotal(suma + cartaElegida.valor(self)) // ...
		cartaElegida.mostrar(persona)
	}
	
	method darVueltaPrimerCarta() {
		mano.get(0).darVuelta()
	}
	
	override method pedirCarta() {
		if (self.sumaMano() < 16 && enJuego) {
			self.darCarta(self)
			game.schedule(1000, { self.pedirCarta() })
		}
		else self.finTurno()
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
	
	override method finTurno() {
		super()
		partida.terminarRonda()
	}
	
	method empezarTurno() {
		self.darVueltaPrimerCarta()
		game.addVisual(self)
		game.schedule(1000, { self.pedirCarta() })
	}
}

object jugador inherits Jugador(posY = 3, posX = 5) {
	
	override method pedirCarta() {
		if (enJuego && not self.sePaso()) repartidor.darCarta(self)
		if (enJuego && self.sePaso()) self.finTurno()
	}
	
	override method finTurno() {
		super()
		game.schedule(750, { repartidor.empezarTurno() })
	}
	
	method plantarse() {
		if (self.enJuego()) {
			self.finTurno()
		}
	}
}


