# Ejercicio 2: Iteradores circulares
Dada la siguiente implementación:

**CharRing.java**
```java
public class CharRing extends Object {
	char[] source;
	int idx;
	public CharRing(String srcString) {
		char result;
		source = new char[srcString.length()];
		srcString.getChars(0, srcString.length(), source, 0);
		result = 0;
		idx = result;
	}
	
	public char next() {
		int result;
		if (idx >= source.length)
			idx = 0;
		result = idx++;
	return source[result]; // línea 18
	}
}
```
**Tareas:**
1) Se quiere aplicar el refactoring Rename Variable sobre la variable result que se usa en la línea 18 con el nuevo nombre currentPosition.
2) ¿Cómo queda el código final y qué inconveniente se podría encontrar?

#### Código final:
```java
public class CharRing extends Object {
	char[] source;
	int idx;
	public CharRing(String srcString) {
		char result;
		source = new char[srcString.length()];
		srcString.getChars(0, srcString.length(), source, 0);
		result = 0;
		idx = result;
	}
	
	public char next() {
		int currentPosition; // result -> currentPosition
		if (idx >= source.length)
			idx = 0;
		currentPosition = idx++; // result -> currentPosition
	return source[currentPosition]; // result -> currentPosition
	}
}
```
Para que el refactoring sea correcto y no altere el comportamiento del programa, también se deben modificar las líneas 14 y 17, cambiando `result` por `currentPosition`.