![[Imágenes/Pasted image 20260422213548.png]]

G = (N, T, S, P)

- `N = {<switch>, <bloque_case>, <case>, <bloque_sentencia>, <sentencia>, <expresión>, <operando>, <operador>, <número>, <identificador>, <palabra>, <caracter>, <letra>, <dígito>, <símbolo>}
- `T = {"switch", `
- `S = <switch>`
- `P = {`
	- `<switch> ::= "switch" "(" <expresión> ")" "{" <bloque_case> "default:" <bloque_sentencia> "}";
	- `<bloque_case> ::= <case> | <case> <bloque_case>`
	-  `<case> ::= "case" <operando> ":" <bloque_sentencia> "break" ";"`
	- `<bloque_sentencia> ::= <sentencia> | <sentencia> <bloque_sentencia> `
	- `<sentencia> ::= <s_for> | <s_foreach> | <s_while> | <s_if> | <operación> | ... ";"`
	- `<expresión> ::= <operando> | <operando> <operador> <operando>`
	- `<operando> ::= <identificador> | <número> | <string_literal> | <char> | ... `
	- `<operador> ::= "+" | "-" | "*" | "/" | ...`
	- `<número> ::= <dígito> | <dígito> <número> `
	- `<identificador> ::= <símbolo_letra> | <símbolo_letra> <palabra>`
	- `<palabra> ::= <caracter> | <caracter> <palabra>`
	- `<símbolo_letra> := <símbolo> | <letra>`
	- `<caracter> ::= <letra> | <dígito> | <símbolo> ` 
	- `<letra> ::= "A" | ... | "Z" | "a" | ... | "z"`
	- `<dígito> ::= "0" | ... | "9" `
	- `<símbolo> ::= "_" | ... ` *símbolos que admita Java para identificadores.*
  `}`
![[Imágenes/Pasted image 20260422213755.png]]


![[Imágenes/Pasted image 20260422214332.png]]
![[Imágenes/Pasted image 20260422220853.png]]

| Identif | L-value    | R-value | Alcance       | T.V.        |
| ------- | ---------- | ------- | ------------- | ----------- |
| Main    | -          | -       | 3-12          | 2-12        |
| c(4)    | automática | basura  | 5-12          | 2-12        |
| o(4)    | automática | basura  | 5-12          | 2-12        |
| r(4)    | automática | basura  | 5-7.3<br>8-12 | 2-12        |
| vec     | automática | basura  | 6-12          | 2-12        |
| c3      | automática | basura  | 7-12          | 2-12        |
| Proc    | -          | -       | 7.1-7.5       | 7-7.5       |
| vec2    | automática | basura  | 7.3-7.5       | 7-7.5       |
| r(7.3)  | automática | nil     | 7.4-7.5       | 7-7.5       |
| r^      | dinámica   | basura  | 7.4-7.5       | 7.4.3-7.4.4 |

![[Pasted image 20260423172744.png]]

```plaintext
*1  ****tachado****
	Reg activ principal
	Punto de retorno
	k = 3, 1..3, 1..3
	est = true, false
	z = 0, 1, 2, 3, 1
	Procedure puno
	Procedure proc2
	Función f
	VR ...
						Imprime:
							write(k; est; z) -> 3 false 1
---------------------------------------
*2  ****tachado****
	Reg activ proc2
	PR
	EE(*1)
	ED(*1)
	f = 1
	VR ...
						Imprime:
							write(f) -> 1
---------------------------------------
*3  ****tachado****
	Reg activ puno
	PR
	EE(*1)
	ED(*2)
	c = 1
	vec[1] = 5
	vec[2] = 7
	vec[3] = 9
	z = 1, 5, 7, 9
	VR 2, 4, 6
						Imprime:
							write(c; z) -> 1 9
							write(vec(1)) -> 5
							write(vec(2)) -> 7
							write(vec(3)) -> 9
---------------------------------------
*4  ****tachado****
	Reg activ f
	PR
	EE(*1)
	ED(*3)
	VR
---------------------------------------
*5  ****tachado****
	Reg activ f
	PR
	EE(*1)
	ED(*3)
	VR
---------------------------------------
*6  ****tachado****
	Reg activ f
	PR
	EE(*1)
	ED(*3)
	VR
```
--- 
![[Imágenes/Pasted image 20260423183523.png]]

**a)** Las variables estáticas en C se almacenan en la memoria de datos estática del programa al momento de compilación, permaneciendo ahí hasta el fin de la ejecución.
Las variables globales y estáticas utilizan inicialización por defecto, es decir que si no se les asigna un valor en su declaración, el lenguaje limpia el espacio de memoria asignando un valor por defecto (por ejemplo 0 para enteros o espacio en blanco para caracteres). Una variable local de algún proceso, función o subprograma, tendrá un valor de inicialización indefinido.

**b)** Sea el siguiente código C-like:
```C
void incrementar() {
	static int m = 0;
	m = m + 1;
}

void main() {
	incrementar();
	incrementar();
}
```
La variable "`m`" tiene alcance dentro de la función `incrementar()` pero su tiempo de vida se extiende hasta que finalice la ejecución de todo el programa. En este escenario, el L-valor (dirección de memoria) de la variable "`m`" tiene un momento de alocación estático. El sistema le reserva un espacio en la zona de datos fija antes de comenzar la ejecución y este espacio no se destruye cuando la función finaliza.

**c)** La afirmación es falsa.