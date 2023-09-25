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
		if (persona.sePaso()) { // Arreglar problema con el as
			valor = 1
			return valor
		}
		valor = 11
		return valor
	}
}


