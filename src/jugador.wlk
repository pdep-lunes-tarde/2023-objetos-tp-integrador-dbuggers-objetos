import carta.*
import mazoDeCartas.*
import wollok.game.*
import tp.*

class Jugador {
	const property mano = new List()
	const property position = new Position()
	var property posUltimaCarta = position.x() + 3
	var property enJuego = false
	
	method sumaCartas() = 
		mano.sum({ carta => carta.valor() })
	
	method sumaTotal() {
		if (self.sumaCartas() <= 21 || self.asesEnManoSinModificar().isEmpty())
			return self.sumaCartas()
		return mano.sum({ carta => carta.valor(self) })
	}
	
	method asesEnManoSinModificar() = mano.filter({
		carta => carta.valor() == 11
	})
	
	method sePaso() = self.sumaTotal() > 21
	
	method text() = "Suma de cartas: " + self.sumaTotal().toString()
	
	method textColor() = "FFFFFF"
	
	method esBlackjack() = self.sumaTotal() == 21 && mano.size() == 2
	
	method finTurno() {
		enJuego = false
	}
	
	method pedirCarta()
	
	method recibirCarta(carta) {
		self.mano().add(carta)
	}
}

object repartidor inherits Jugador(position = new Position(x = 2, y = 10)) {
	const property mazoEnPartida = new List()
	
	method repartirCartasIniciales() {
		2.times({i => self.darCarta(self) })
		2.times({i => self.darCarta(jugador) })
		self.darVueltaPrimerCarta()
	}
	
	method darCarta(persona) {
		const cartaElegida = self.elegirCartaAleatorio()
		persona.recibirCarta(cartaElegida)
		cartaElegida.mostrar(persona)
	}
	
	method darVueltaPrimerCarta() {
		mano.get(0).darVuelta()
	}
	
	override method pedirCarta() {
		if (self.sumaTotal() < 16 && enJuego) {
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

object jugador inherits Jugador(position = new Position(x = 2, y = 3)) {
	
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


