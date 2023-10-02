import carta.*
import mazoDeCartas.*
import wollok.game.*

object repartidor {
	const property mazoEnPartida = new List()
	const property mano = new List()
	var property sumaTotal = 0
	const property posY = 10
	var property posX = 5
	//var property estado = "En juego"
	
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
		const x = persona.posX()
		persona.posX(x+2)
		persona.mano().add(cartaElegida)
		persona.sumaTotal(suma + cartaElegida.valor(self))
		const pos = game.at(x,persona.posY())
		game.addVisualIn(cartaElegida, pos)
	}
	
	method pedirCarta() {
		self.darCarta(self)
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
	
	method sePaso() = self.sumaMano() > 21 // Esto consultarlo a la hora de pedir cartas
	
	/*method plantarse() {
		estado = "Se planto"
	}*/
	
	method esBlackjack() = self.sumaMano() == 21 && mano.size() == 2
}

object jugador {
	const property mano = new List()
	var property sumaTotal = 0
	const property posY = 3
	var property posX = 5
	//var property estado = "En juego"
	
	method sumaMano() = mano.sum({carta => carta.valor(self)})
	
	method pedirCarta() {
		repartidor.darCarta(self)
	}
	
	method sePaso() = self.sumaMano() > 21
	
	/*method plantarse() {
		estado = "Se planto"
	}*/
	
	method esBlackjack() = self.sumaMano() == 21 && mano.size() == 2
}


