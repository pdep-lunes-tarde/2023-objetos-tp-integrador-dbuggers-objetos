import carta.*
import mazoDeCartas.*
import wollok.game.*
import tp.*

/* class SumaCartas {
	var property total = 0
	
	method restarAsModificado() {
		total -= 10
	}
} */

class Jugador {
	const property mano = new List()
	const property position = new Position()
	var property posUltimaCarta = position.x() + 2
	
	method sumaSinModificar() = 
		mano.sum({ carta => carta.valor() })
	/*
	method sumaTotal() {
		const suma = new SumaCartas(total = self.sumaMano())
		if (suma.total() <= 21 || self.asesEnManoSinModificar().isEmpty())
			return suma.total()
		self.actualizarAses(suma)
		return suma.total()
	}
	
	method sumaTotal() {
		const suma = new SumaCartas(total = self.sumaSinModificar())
		self.asesEnMano().forEach { as =>
			if(suma.total() > 21) suma.restarAsModificado()
		}
		return suma.total()
	} */
	
	method sumaTotal() =
		self.calcularSumaConAses(self.asesEnMano().size(), self.sumaSinModificar())
	
	method calcularSumaConAses(cantAases, suma) {
		if(suma <= 21 || cantAases == 0) return suma
		return self.calcularSumaConAses(cantAases-1, suma-10)
	}
	
	method asesEnMano() = mano.filter({
		carta => carta.valor() == 11
	})
	
	method sePaso() = self.sumaTotal() > 21
	
	method text() = "Suma de cartas: " + self.sumaTotal().toString()
	
	method textColor() {
		if (partida.esJugadorActual(self)) return "FFFF00"
		return "FFFFFF"
	} 
	
	method esBlackjack() = self.sumaTotal() == 21 && mano.size() == 2
	
	method pedirCarta() {
		if (not self.sePaso()) repartidor.darCarta(self)
		if (self.sePaso()) partida.siguienteTurno()
	}
	
	method recibirCarta(carta) {
		self.mano().add(carta)
	}
	
	method plantarse() {
		partida.siguienteTurno()
	}
	
	method devolverCartas() {
		self.mano().clear()
		posUltimaCarta = position.x() + 2
	}
}

object repartidor inherits Jugador(position = new Position(x = game.width()/2-3, y = game.height()-4)) {
	const property mazoEnPartida = new List()
	
	method repartirCartasIniciales() {
		partida.listaJugadores().forEach {
			jugador => 2.times({i => self.darCarta(jugador) })
		}
		2.times({i => self.darCarta(self) })
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
		if (self.sumaTotal() < 16) {
			self.darCarta(self)
			game.schedule(1000, { self.pedirCarta() })
		}
		else {
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
	
	method empezarTurno() {
		self.darVueltaPrimerCarta()
		game.addVisual(self)
		game.schedule(1000, { self.pedirCarta() })
	}
}
