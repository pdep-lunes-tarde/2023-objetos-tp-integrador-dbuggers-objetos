import carta.*

object mazo {
	const palos = ['♣','♥','♠','♦']
	const indices = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
	const valores = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
	var index = -1
	//const indicesYValores = new Dictionary()
	
	/* method crearRegistroIndicesYValores() {
		const indices = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
		const valores = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
		self.agregarIndicesYValores(indices, valores)
	}
	
	method agregarIndicesYValores(indices, valores) {
		if (not indices.isEmpty()) {
			indicesYValores.put(indices.first(), valores.first())
			self.agregarIndicesYValores(indices.drop(1), valores.drop(1))
		}
	} */
	
	method mazoLleno() {
		// self.crearRegistroIndicesYValores()
		index = -1
		return indices.map({
			indice => self.cadaPaloIndice(indice)
		}).flatten()
	}
	
	method cadaPaloIndice(indice) {
		index ++
		return palos.map({
			palo => return self.agregarCarta(palo, indice)
		})
	}
	
	method agregarCarta(palo, id) {
		const valorCarta = valores.get(index)
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
}
