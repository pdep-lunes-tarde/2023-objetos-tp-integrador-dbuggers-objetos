import wollok.game.*
import jugador.*

object configuracion {
	
	method teclasElegirJugador() {
		keyboard.num1().onPressDo { partida.asignarJugadores(1) }
		keyboard.num2().onPressDo { partida.asignarJugadores(2) }
		keyboard.num3().onPressDo { partida.asignarJugadores(3) }
	}
	
	method configEmpezar() {
		keyboard.space().onPressDo { partida.empezarRonda() }
	}
	
	method teclasJuego() {
		keyboard.p().onPressDo { partida.jugadorActual().pedirCarta() }
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
					new Jugador(position = self.posJugadores(i))
				)
		}
		game.clear()
		configuracion.configEmpezar()
		game.addVisual(cartelEmpezar)
	}
	
	method agregarJugador(jugador) {
		listaJugadores.add(jugador)
	}
	
	method siguienteTurno() {
		jugadorEnJuego++
		if (listaJugadores.size() == jugadorEnJuego) {
			keyboard.p().onPressDo { }
			keyboard.s().onPressDo { }
			repartidor.empezarTurno()
		}
		else if (self.jugadorActual().esBlackjack()) self.siguienteTurno()
	}
	
	method posJugadores(i) {
		if (i == 1) return new Position(x = 2, y = 2)
		if (i == 2) return new Position(x = 13, y = 2)
		return new Position(x = 24, y = 2)
	}
	
	method empezarRonda() {
		if (not partidaEnJuego) {
			if (game.hasVisual(cartelEmpezar)) game.removeVisual(cartelEmpezar)
			repartidor.llenarMazo()
			repartidor.repartirCartasIniciales()
			listaJugadores.forEach {
				jugador => game.addVisual(jugador)
			}
			game.addVisual(cartelTeclas)
			self.partidaEnJuego(true)
			configuracion.teclasJuego()
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
				jugador.position().up(3)
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
		game.addVisual(cartelEmpezar)
		self.partidaEnJuego(false)
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
	const property position = new Position(x=game.width()-4, y=game.height()-3)
	
	method textColor() = "FFFFFF"
	method text() = "Presione <p> para pedir\nPresione <s> para plantarte"
}


