# Sintaxis

**Objetivo:** conocer como se define léxicamente un lenguaje de programación y cuales son las herramientas necesarias para hacerlo

---

### Ejercicio 1: Complete el siguiente cuadro:

| **Meta símbolos utilizados por BNF** | **Meta símbolos utilizados por EBNF** | **Símbolo utilizado en diagramas sintácticos** | **Significado**                       |
| ------------------------------------ | ------------------------------------- | ---------------------------------------------- | ------------------------------------- |
| palabra terminal                     | palabra terminal                      | Óvalo                                          | Definición de un elemento terminal    |
| <>                                   | <>                                    | rectángulo                                     | Definición de un elemento no terminal |
| ::=                                  | ::=                                   | diagrama con rectángulos, óvalos y flechas     | Definición de una producción          |
| \|                                   | (\|)                                  | flecha que se divide en dos o más caminos      | Selección de una alternativa          |
| \<p><p~1>                            | { }                                   |                                                | Repetición                            |
| -                                    | *                                     | ![[Pasted image 20260404143326.png]]           | Repetición de 0 o más veces           |
| -                                    | +                                     | ![[Pasted image 20260421111530.png]]           | Repetición de 1 o más veces           |
| -                                    | []                                    | ![[Pasted image 20260404143339.png]]           | Opcional                              |

**Nota:** p y p1 son producciones simbólicas

---

### Ejercicio 2: ¿Cuál es la importancia de la sintaxis para un lenguaje? ¿Cuáles son sus elementos?

La sintaxis es la base de un lenguaje de programación. Proporciona un conjunto de reglas sintácticas y gramaticales que determinan cómo se deben estructurar las instrucciones del lenguaje y define la forma válida de los programas. Esto es importante para facilitar y agilizar la tarea del programador, a la hora de aprender o desarrollar con determinado lenguaje.
Permite escribir programas correctos y válidos sintácticamente. Establece reglas para combinar componentes básicas, llamadas "word" y formar sentencias y programas.
La componen los siguientes elementos:
- alfabeto o conjunto de caracteres
- identificadores
- operadores
- palabra clave y palabra reservada
- comentarios y uso de blancos
---
### Ejercicio 3: ¿Explique a qué se denomina regla lexicográfica y regla sintáctica?

La regla lexicográfica reconoce lexemas (cadenas de caracteres) y genera componentes léxicos válidos en forma de tokens. Estos representan categorías como identificadores, números o palabras reservadas.
La regla sintáctica recibe los tokens y define cómo deben combinarse y estructurarse, construyendo un árbol sintáctico para formar estructuras lógicas mayores.

---
### Ejercicio 4

- ¿En la definición de un lenguaje, a qué se llama palabra reservadas?
  Una palabra reservada es una palabra clave que además no puede ser usada por el programador como identificador de otra entidad.
  
- ¿A qué son equivalentes en la definición de una gramática?

- De un ejemplo de palabra reservada en el lenguaje que más conoce. (Ada, C, Ruby, Python,..)
  for, while, if, etc.
  
---
### Ejercicio 5

Dada la siguiente gramática escrita en BNF:

$G=(N,T,S,P)$

- N = {<numero_entero>, \<digito>}
- T=\{0, 1, 2, 3, 4, 5, 6, 7, 8, 9\}
- S = <numero_entero>
- P = {
	- <numero_entero>::=\<digito><numero_entero> | <numero_entero>\<digito> | \<digito>
	- \<digito>::=0|1|2|3|4|5|6|7|8|9
	  }

**a)** Identifique las componentes de la misma
- **N**: componentes no terminales.
- **T**: componentes terminales.
- **S**: símbolo inicial o axioma, es el elemento a definir.
- **P**: producciones.
 
**b)** Indique porqué es ambigua y corríjala
Es ambigua porque tiene más de una posible forma de derivación, la regla de producción para `<número_entero>` permite simultáneamente recursión por derecha y por izquierda.
La definición correcta es:
`<numero_entero> ::= <digito><numero_entero> | <digito>`

---

### Ejercicio 6: Defina en BNF (Gramática de contexto libre desarrollada por Backus-Naur) la gramática para la definición de una palabra cualquiera.

$G=(N,T,S,P)$

- N = {\<palabra>, \<letra>}
- T = {a, b, c, d, e, f, g, h, i, j, k, l, m, n, ñ, o, p, q, r, s, t, u, v, w, x, y, z
  A, B, C, D, E, F, G, H, I, J, K, L, M, N, Ñ, O, P, Q, R, S, T, U, V, W, X, Y, Z}
  *¿faltarían vocales con tilde?*
- S = \<palabra>
- P = {
	- \<palabra> ::= \<palabra>\<letra> | \<letra>
	- \<letra> ::= a | b | c | ... | z | A | B | C | ... | Z
  }

---
### Ejercicio 7: Defina en EBNF la gramática para la definición de números reales. Inténtelo desarrollar para BNF y explique las diferencias con la utilización de la gramática EBNF.

##### EBNF:
$G=(N,T,S,P)$

- N = {\<número_real>, \<número_entero>, \<dígito>, \<signo>}
- T = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, ",", +, -}
- S = \<número_real>
- P = {
	- \<número_real> ::= \[\<signo>] \<número_entero> \["," \<número_entero>]
	- \<número_entero> ::= {\<dígito>}+
	- \<signo> ::= + | -
	- \<dígito> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
  }

##### BNF:
- P = {
	- \<número_real> ::= <número_entero> | \<número_entero> "," \<número_entero> | \<signo> \<número_entero> | \<signo> \<número_entero> "," \<número_entero>
	- \<número_entero> ::= \<número_entero><dígito> | <dígito> 
	- \<signo> ::= + | -
	- \<dígito> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
  }

BNF utiliza la recursividad para reutilizar elementos ya definidos. EBNF implementa la repetición con el uso de llaves `{ }` para un elemento que puede aparecer 0 o más veces (`*`) o una o más veces (`+`).

---
### Ejercicio 8

Utilizando la gramática que desarrolló en los puntos 6 y 7, escriba el árbol sintáctico de:
- **a.** Conceptos
- **b.** Programación
- **c.** 1255869
- **d.** 854,26
- **e.** Conceptos de lenguajes

**a)**
![[Pasted image 20260421134812.png]]

**b)**
![[Pasted image 20260421135246.png]]

**c)**
![[Pasted image 20260421135828.png]]

**d)**
![[Pasted image 20260421141739.png]]

**e)** La gramática definida para palabras no admite oraciones (*porque no tiene definido el espacio " "*).

---
### Ejercicio 9: Defina utilizando diagramas sintácticos la gramática para la definición de un identificador de un lenguaje de programación. Tenga presente como regla que un identificador no puede comenzar con números.

![[Pasted image 20260421145852.png]]

---
### Ejercicio 10

- **a)** Defina con EBNF la gramática para una expresión numérica, dónde intervienen variables y números. Considerar los operadores +, -, * y / sin orden de prioridad. No considerar el uso de paréntesis.
- **b)** A la gramática definida en el ejercicio anterior agregarle prioridad de operadores.
- **c)** Describa con sus palabras los pasos y decisiones que tomó para agregarle prioridad de operadores al ejercicio anterior.

---

### Ejercicio 11

La siguiente gramática intenta describir sintácticamente la sentencia for de ADA, indique cuál/cuáles son los errores justificando la respuesta.

**N** = {`<sentencia_for>`, `<bloque>`, `<variable>`, `<letra>`, `<cadena>`, `<digito>`, `<otro>`, `<operacion>`, `<llamada_a_funcion>`, `<numero>`, `<sentencia>`}

**P** = { `<sentencia_for>::= for (i= IN 1..10) loop <bloque> end loop;` `<variable>::= <letra> | <cadena>` `<cadena>::= {(<letra> | <digito> | <otro>)}+` `<letra>::=(a | .. |z|A|..|Z)` `<digito>::= (1|2|3|4|5|6|7|8|9|0)` `<bloque>::= <sentencia> | <sentencia> <bloque> | <bloque> <sentencia>;` `<sentencia>::= <sentencia_asignacion> | <llamada_a_funcion> | <sentencia_if> | <sentencia_for> | <sentencia_while> | <sentencia_switch>` }

---

### Ejercicio 12

Realice en EBNF la gramática para la definición un tag div en html 5. (Puede ayudarse con el siguiente enlace ([https://developer.mozilla.org/es/docs/Web/HTML/Elemento/div](https://developer.mozilla.org/es/docs/Web/HTML/Elemento/div))

### Ejercicio 13

Defina en EBNF una gramática para la construcción de números primos. ¿Qué debería agregar a la gramática para completar el ejercicio?

### Ejercicio 14

Sobre un lenguaje de su preferencia escriba en EBNF la gramática para la definición de funciones o métodos o procedimientos (considere los parámetros en caso de ser necesario)