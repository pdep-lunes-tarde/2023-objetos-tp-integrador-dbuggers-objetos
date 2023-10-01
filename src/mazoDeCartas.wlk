import carta.*

object mazo {
	const palos = ['♣','♥','♠','♦']
	const indicesYValores = new Dictionary()
	
	method crearRegistroIndicesYValores() {
		const indices = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
		const valores = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
		self.agregarIndicesYValores(indices, valores)
	}
	
	method agregarIndicesYValores(indices, valores) {
		if (not indices.isEmpty()) {
			indicesYValores.put(indices.first(), valores.first())
			self.agregarIndicesYValores(indices.drop(1), valores.drop(1))
		}
	}
	
	method mazoLleno() {
		self.crearRegistroIndicesYValores()
		return indicesYValores.keys().map({
			indice => palos.map({
				palo => return self.agregarCarta(palo, indice)
			})
		}).flatten()
	}
	
	method agregarCarta(palo, id) {
		const valorCarta = indicesYValores.get(id)
		if (id == 'A') {
			return new As(indice = palo + id)
		}
		return new Carta(indice = palo + id, valor = valorCarta)
	}
}
