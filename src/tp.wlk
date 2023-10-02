import wollok.game.*
import jugador.*

object configuracion {
	method config() {
		keyboard.space().onPressDo { partida.empezarRonda() }
		keyboard.p().onPressDo { jugador.pedirCarta() }
		keyboard.s().onPressDo { jugador.plantarse() }
	}
}

object partida {
	var property partidaEnJuego = false
	
	method empezarRonda() {
		if (not partidaEnJuego) {
			game.removeVisual(cartelEmpezar)
			self.partidaEnJuego(true)
			repartidor.llenarMazo()
			repartidor.repartirCartasIniciales()
			repartidor.enJuego(true)
			jugador.enJuego(true)
			game.addVisual(jugador)
			game.addVisual(repartidor)
			if (jugador.esBlackjack()) self.terminarRonda()
			// if (repartidor.esBlackjack()) self.terminarRonda()
		}
		
	}
	
	method terminarRonda() {
		self.partidaEnJuego(false)
		game.addVisual(cartelResultado)
		game.schedule(5000, {self.reiniciarTablero()})
	}
	
	method reiniciarTablero() {
		game.clear()
		jugador.mano().clear()
		jugador.sumaTotal(0)
		jugador.posX(5)
		repartidor.mano().clear()
		repartidor.sumaTotal(0)
		repartidor.posX(5)
		configuracion.config()
		game.addVisual(cartelEmpezar)
	}
	
	method ganador() {
		if (jugador.esBlackjack()) return "¡BlackJack!"
		if (jugador.sePaso() && repartidor.sePaso()) return "Ambos se pasaron"
		if (jugador.sePaso()) return "Perdiste"
		if (repartidor.sePaso()) return "Ganaste"
		if (jugador.sumaMano() == repartidor.sumaMano()) return "Empate"
		if (jugador.sumaMano() > repartidor.sumaMano()) return "Ganaste"
		return "Perdiste"
	}
}

class Cartel {
	const property position = game.center()
	
	method textColor() = "FFFFFF"
}

object cartelResultado inherits Cartel {
	method text() = partida.ganador()
}

object cartelEmpezar inherits Cartel {
	method text() = "Apretar <espacio> para empezar"
}

object cartelCargando inherits Cartel {
	method text() = "Cargando..."
}



