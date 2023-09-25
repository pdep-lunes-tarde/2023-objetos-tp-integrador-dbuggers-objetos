# Grupo

Nombre: Dbuggers

Integrantes:

- Legajo: 160766-2 
- Nombre: Alejo Travieso

- Legajo: 209180-0
- Nombre: Gonzalo Salas Vetre

- Legajo: 1675060 
- Nombre: Matias Daniel Iannuccilli

Juego: Blackjack

# Consigna TP Integrador

Hacer un juego aplicando los conceptos de la materia. El tp tiene una parte práctica, que es programar el juego en sí, y una parte teórica, que es justificar decisiones que hayan tomado y mencionar para resolver qué problemas utilizaron los conceptos de la materia.
El TP debe:
- aplicar los conceptos que vemos durante la materia.
- tener tests para las funcionalidades que definan.
- evitar la repetición de lógica.

# Como correrlo

Boton derecho sobre `juego.wpgm > Run as > Wollok Program`.

# Entregas

Van a haber varios checkpoints presenciales en los cuales vamos a ver el estado del tp, dar correcciones y junto con ustedes decidir en qué continuar trabajando.
Los checkpoints presenciales están en la página: https://www.pdep.com.ar/cursos/lunes-tarde

# Parte teórica

Les vamos a ir dando preguntas para cada checkpoint que **tienen que** dejar contestadas por escrito. Pueden directamente editar este README.md con sus respuestas:

--------------------

## Checkpoint 1: 25/9

a) Detectar un conjunto de objetos que sean polimórficos entre sí, aclarando cuál es la interfaz según la cuál son polimórficos, y _quién_ los trata de manera polimórfica.

b) Tomar alguna clase definida en su programa y justificar por qué es una clase y no se definió con `object`.

c) De haber algún objeto definido con `object`, justificar por qué.

### Respuestas:

a) Carta y As son polimórficos porque ambos contienen un índice y valor, y el jugador y el repartidor los usan de forma polimórfica a la hora de calcular la suma de las cartas.
Jugador y Repartidor son polimórficos porque ambos contienen una mano y tienen los métodos sumaMano y sePaso, además son usados para verificar el valor a tomar del As.

b) Carta y As son clases porque puede haber varias instancias de estos, por ejemplo, cartas de diferentes valores o diferentes palos.

c) Repartidor es un objeto porque es único y el jugador es objetos porque por ahora es solo 1.
