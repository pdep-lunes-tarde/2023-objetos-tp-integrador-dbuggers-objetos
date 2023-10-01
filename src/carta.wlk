// ♣♥♠♦

class Carta {
	const property indice
	const property valor
	
	method valor(persona) = valor
}

class As {
	const property indice
	var property valor = 11

	method valor(persona) {
		const suma = persona.sumaTotal()
		if (suma > 21 && valor == 11) { // Arreglar problema con el as
			valor = 1
			persona.sumaTotal(suma-10)
		}
		return valor
	}
}


