import wollok.game.*
import jugador.*

object configuracion {
	
	method teclasElegirJugador() {
		game.addVisual(cartelInicial)
		keyboard.num1().onPressDo { partida.asignarJugadores(1) }
		keyboard.num2().onPressDo { partida.asignarJugadores(2) }
		keyboard.num3().onPressDo { partida.asignarJugadores(3) }
	}
	
	method configEmpezar() {
		game.addVisual(cartelEmpezar)
		game.addVisual(cartelMenu)
		keyboard.space().onPressDo { partida.empezarRonda() }
		keyboard.q().onPressDo { partida.volverAElegirJugadores() }
	}
	
	method teclasJuego() {
		game.addVisual(cartelTeclas)
		keyboard.p().onPressDo {partida.jugadorActual().pedirCarta() }
		keyboard.s().onPressDo { partida.jugadorActual().plantarse() }
		
	}
}

object partida {
	var property partidaEnJuego = false
	var property listaJugadores = new List()
	var jugadorEnJuego = 0
	
	method jugadorActual() {
		if (jugadorEnJuego < listaJugadores.size())
			return listaJugadores.get(jugadorEnJuego)
		return repartidor
	}
	
	method esJugadorActual(jugador) = self.jugadorActual() == jugador
	
	method asignarJugadores(n) {
		n.times {
			i => listaJugadores.add(
					new Jugador(position = 
						new Position(x = self.posXJugador(i, n), y = 3)
					)
				)
		}
		game.clear()
		configuracion.configEmpezar()
	}
	
	method agregarJugador(jugador) {
		listaJugadores.add(jugador)
	}
	
	method siguienteTurno() {
		jugadorEnJuego++
		if (listaJugadores.size() == jugadorEnJuego) repartidor.empezarTurno()
		else if (self.jugadorActual().esBlackjack()) self.siguienteTurno()
	}
	
	method posXJugador(i , n) {
		var aux = 3
		if (n.even()) {
			if (i < (n+1)/2) aux -= (i - n/2 - 1)*(5-n)
			else aux -= (i - n/2)*(5-n)
		}
		else aux -= (i - ((n+1)/2))*(6-n)
		return game.width() * i / (n+1) - aux
		/* if (cantJugadores == 1) return game.center().x() - 3
		if (cantJugadores == 2) {
			if (i == 1) return game.width()/3 - 5
			return game.width()*2/3 - 1
		}
		if (i == 1) return game.width()/4 - 5
		if (i == 2) return game.center().x() - 3
		return game.width()*3/4 - 1 */
	}
	
	method cantJugadores() = listaJugadores.size()
	
	method empezarRonda() {
		if (not partidaEnJuego) {
			if (game.hasVisual(cartelEmpezar)) game.removeVisual(cartelEmpezar)
			repartidor.llenarMazo()
			repartidor.repartirCartasIniciales()
			listaJugadores.forEach {
				jugador => game.addVisual(jugador)
			}
			self.partidaEnJuego(true)
			configuracion.teclasJuego()
			if (self.jugadorActual().esBlackjack()) self.siguienteTurno()
		}
	}
	
	method terminarRonda() {
		self.mostrarResultados()
		game.schedule(5000, {self.reiniciarTablero()})
	}
	
	method mostrarResultados() {
		listaJugadores.forEach {
			jugador => game.addVisualIn(
				self.resultado(jugador),
				jugador.position().up(3).right(3)
			)
		}
	}
	
	method reiniciarTablero() {
		game.clear()
		listaJugadores.forEach {
			jugador => jugador.devolverCartas()
		}
		repartidor.devolverCartas()
		configuracion.configEmpezar()
		jugadorEnJuego = 0
		self.partidaEnJuego(false)
	}
	
	method volverAElegirJugadores() {
		listaJugadores.clear()
		jugadorEnJuego = 0
		partidaEnJuego = false
		repartidor.devolverCartas()
		game.clear()
		configuracion.teclasElegirJugador()
	}
	
	method resultado(jugador) {
		if (jugador.esBlackjack() && repartidor.esBlackjack())
			return new CartelResultado(text = "Empate", textColor = "FFFFFF")
		
		if (jugador.esBlackjack())
			return new CartelResultado(text = "¡BlackJack!", textColor = "00FF00")
		
		if (repartidor.esBlackjack())
			return new CartelResultado(text = "Perdiste por BlackJack")
		
		if (jugador.sePaso() && repartidor.sePaso())
			return new CartelResultado(text = "Ambos se pasaron", textColor = "FFFFFF")
		
		if (jugador.sePaso())
			return new CartelResultado(text = "Perdiste")
		
		if (repartidor.sePaso() || jugador.sumaTotal() > repartidor.sumaTotal())
			return new CartelResultado(text = "Ganaste", textColor = "00FF00")
		
		if (jugador.sumaTotal() == repartidor.sumaTotal())
			return new CartelResultado(text = "Empate", textColor = "FFFFFF")
		
		return new CartelResultado(text = "Perdiste")
	}
}

class Cartel {
	const property position = game.center()
	
	method textColor() = "FFFFFF"
}

class CartelResultado {
	var property text
	var property textColor = "FF0000"
}

object cartelEmpezar inherits Cartel {
	method text() = "Apretar <espacio> para empezar"
}

object cartelInicial inherits Cartel {
	method text() = "Presione del 1-3 para elegir la cantidad de jugadores"
}

object cartelCargando inherits Cartel {
	method text() = "Cargando..."
}

object cartelTeclas {
	const property position = new Position(x=game.width()-4, y=game.height()-2)
	
	method textColor() = "FFFFFF"
	method text() = "Presione <p> para pedir\nPresione <s> para plantarte"
}

object cartelMenu {
	const property position = new Position(x= 3, y=game.height()-2)
	
	method textColor() = "FFFFFF"
	method text() = "Presione <q> para volver al menu"
}


