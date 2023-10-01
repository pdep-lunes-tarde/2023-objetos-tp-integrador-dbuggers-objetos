import carta.*
import mazoDeCartas.*

object repartidor {
	const property mazoEnPartida = new Set()
	const property mano = new List()
	var property sumaTotal = 0
	//var property estado = "En juego"
	
	method repartirCartasIniciales() {
		self.darCarta(jugador)
		self.darCarta(jugador)
		self.recibirCarta()
		self.recibirCarta()
	}
	
	method sumaMano() = mano.sum({carta => carta.valor(self)})
	
	method darCarta(persona) {
		const cartaElegida = self.elegirCartaAleatorio()
		const suma = persona.sumaMano()
		persona.mano().add(cartaElegida)
		persona.sumaTotal(suma + cartaElegida.valor(self))
	}
	
	method recibirCarta() {
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
	//var property estado = "En juego"
	
	method sumaMano() = mano.sum({carta => carta.valor(self)})
	
	method pedirCarta() {
		repartidor.darCarta(self)
	}
	
	method sePaso() = self.sumaMano() > 21
	
	//method sumaManoActual() = mano.sum({carta => carta.valor()})
	
	//method seVaAPasar() = self.sumaManoActual() > 21
	
	/*method sePaso() {
		if (self.sumaMano() > 21) {
			estado = "Se paso"
			return true 
		}
		return false
	}*/
	
	/*method plantarse() {
		estado = "Se planto"
	}*/
	
	method esBlackjack() = self.sumaMano() == 21 && mano.size() == 2
}


