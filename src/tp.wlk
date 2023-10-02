import wollok.game.*
import jugador.*

object configuracion {
	method config() {
		game.width(25)
  		game.height(15)
		
		game.boardGround("./imagenes/fondo/fondo_blackjack.jpg")
		
		keyboard.space().onPressDo { partida.empezarRonda() }
		keyboard.p().onPressDo { jugador.pedirCarta() }
		keyboard.s().onPressDo { jugador.plantarse() }
	}
}

object partida {
	var property partidaEnJuego = false
	
	method empezarRonda() {
		if (not partidaEnJuego) {
			self.partidaEnJuego(true)
			repartidor.llenarMazo()
			repartidor.repartirCartasIniciales()
			repartidor.enJuego(true)
			jugador.enJuego(true)
			game.addVisual(jugador)
			game.addVisual(repartidor)
			if (jugador.esBlackjack()) self.mostrarCartel()
			if (repartidor.esBlackjack()) self.mostrarCartel2()
		}
		
	}
	
	method terminarRonda() {
		self.partidaEnJuego(false)
		game.addVisual(cartel)
		game.schedule(3000, {game.clear()})
	}
	
	method ganador() {
		if (jugador.sePaso() && repartidor.sePaso()) return "Ambos se pasaron"
		return ""
	}
	
	method mostrarCartel() {
		game.say(jugador, "Ganaste")
	}
	
	method mostrarCartel2() {
		game.say(jugador, "Perdiste")
	}
}

object cartel {
	const property position = game.center()
	
	method text() = partida.ganador()
}