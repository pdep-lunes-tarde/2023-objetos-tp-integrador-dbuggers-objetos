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
	//listaJugadores -> ej: [jugador1, jugador2, repartidor]
	//jugadorEnJuego -> ej: jugador2
	
	method empezarRonda() {
		if (not partidaEnJuego) {
			if (game.hasVisual(cartelEmpezar)) game.removeVisual(cartelEmpezar)
			self.partidaEnJuego(true)
			repartidor.llenarMazo()
			repartidor.repartirCartasIniciales()
			repartidor.enJuego(true)
			jugador.enJuego(true)
			game.addVisual(jugador)
			game.addVisual(cartelTeclas)
			if (jugador.esBlackjack()) {
				repartidor.darVueltaPrimerCarta()
				self.terminarRonda()
			}
			// if (repartidor.esBlackjack()) self.terminarRonda()
		}
		
	}
	
	method terminarRonda() {
		game.addVisual(cartelResultado)
		game.schedule(3500, {self.reiniciarTablero()})
	}
	
	method reiniciarTablero() {
		game.clear()
		jugador.mano().clear()
		jugador.posUltimaCarta(5)
		repartidor.mano().clear()
		repartidor.posUltimaCarta(5)
		configuracion.config()
		game.addVisual(cartelEmpezar)
		self.partidaEnJuego(false)
	}
	
	method resultado() {
		if (jugador.esBlackjack() && repartidor.esBlackjack()) return "Empate"
		if (jugador.esBlackjack()) return "¡BlackJack!"
		if (repartidor.esBlackjack()) return "Perdiste por BlackJack"
		if (jugador.sePaso() && repartidor.sePaso()) return "Ambos se pasaron"
		if (jugador.sePaso()) return "Perdiste"
		if (repartidor.sePaso() || jugador.sumaTotal() > repartidor.sumaTotal()) return "Ganaste"
		if (jugador.sumaTotal() == repartidor.sumaTotal()) return "Empate"
		return "Perdiste"
	}
}

class Cartel {
	const property position = game.center()
	
	method textColor() = "FFFFFF"
}

object cartelResultado inherits Cartel {
	method text() = partida.resultado()
}

object cartelEmpezar inherits Cartel {
	method text() = "Apretar <espacio> para empezar"
}

object cartelCargando inherits Cartel {
	method text() = "Cargando..."
}

object cartelTeclas {
	const property position = new Position(x=game.width()-4, y=game.height()-2)
	
	method textColor() = "FFFFFF"
	method text() = "Presione <p> para pedir\nPresione <s> para plantarte"
}


