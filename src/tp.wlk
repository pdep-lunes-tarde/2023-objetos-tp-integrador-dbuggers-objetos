import wollok.game.*
import jugador.*

object configuracion {
	method config() {
		game.width(25)
  		game.height(15)
		
		game.boardGround("./imagenes/fondo/fondo_blackjack.jpg")
		
		keyboard.p().onPressDo { jugador.pedirCarta() }
	}
}

object partida {
	method empezarRonda() {
		repartidor.llenarMazo()
		repartidor.repartirCartasIniciales()
		if (jugador.esBlackjack()) self.mostrarCartel()
	}
	
	method mostrarCartel() {
		game.say(jugador, "Ganaste")
	}
}
