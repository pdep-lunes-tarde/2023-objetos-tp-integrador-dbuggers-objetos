import carta.*

object mazo {
	const palos = ['♣','♥','♠','♦']
	const indices = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
	const valores = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
	
	method mazoLleno() {
		return indices.map({
			indice => palos.map({
				palo => return self.agregarCarta(palo, indice)
			})
		}).flatten()
	}
	
	method agregarCarta(palo, id) {
		const valorCarta = valores.get(self.indicesIndexOf(id))
		const imagen = "./imagenes/cartas/" + id + "_of_" + self.nombrePalo(palo) + ".png"
		if (id == 'A') {
			return new As(
				indice = palo + id,
				valor = valorCarta,
				frente = imagen
			)
		}
		return new Carta(
			indice = palo + id,
			valor = valorCarta,
			frente = imagen
		)
	}
	
	method nombrePalo(palo) {
		if (palo == '♣') return "clubs"
		if (palo == '♥') return "hearts"
		if (palo == '♠') return "spades"
		if (palo == '♦') return "diamonds"
		return ""
	}
	
	method indicesIndexOf(elem) {
		return self.buscarElemento(indices, elem, 0)	
	}
	
	method buscarElemento(lista, elem, i) {
		if (i == lista.size()) return -1
		if (elem == lista.get(i)) return i
		return self.buscarElemento(lista, elem, i+1)
	}
}
