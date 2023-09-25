import wollok.game.*
import jugador.*

object tpIntegrador {
	method jugar() {
		game.width(25)
  		game.height(15)
		game.addVisual(carta)
		game.boardGround("./imagenes/fondo/fondo_blackjack.jpg")
		game.start()
	}
}

object partida {
	method empezarRonda() {
		repartidor.llenarMazo()
		repartidor.repartirCartasIniciales()
	}
}

object carta {
  var property position = game.origin()

  method image() = "./imagenes/cartas/carta.png"
}