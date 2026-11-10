# Ejercicio 8 - Documentos y estadísticas
Dado el siguiente código implementado en la clase Document y que calcula algunas estadísticas del mismo:
```Java
public class Document {
	List<String> words;
	
	public long characterCount() {
		long count = this.words
				.stream()
				.mapToLong(w -> w.length())
				.sum();
		
		return count;
	}
	
	public long calculateAvg() {
		long avgLength = this.words
				.stream()
				.mapToLong(w -> w.length())
				.sum() / this.words.size();
		
		return avgLength;
	}
// Resto del código que no importa
}
```
**Tareas:**
### 1. Enumere los code smell y que refactorings utilizará para solucionarlos.
- Uncommunicative name (`calculateAvg`) -> Rename method
- Duplicate code -> Extract Method
- Variables innecesarias -> Inline Temp
### 2. Aplique los refactorings encontrados, mostrando el código refactorizado luego de aplicar cada uno.
### Bad smell: Uncommunicative name
`calculateAvg()` no da a entender bien qué hace. Avg de qué?
```Java
public class Document {
	List<String> words;
	
	public long characterCount() {
		long count = this.words
				.stream()
				.mapToLong(w -> w.length())
				.sum();
		
		return count;
	}
	
	public long calculateAvgWordLength() {
		long avgLength = this.words
				.stream()
				.mapToLong(w -> w.length())
				.sum() / this.words.size();
		
		return avgLength;
	}
// Resto del código que no importa
}
```

### Bad smell: Duplicate code
El método `characterCount()` puede invocarse para evitar duplicar la lógica en el segundo método. Aplico lo que sería *Extract Method*, pero el método ya está hecho y es `characterCount()`.
```Java
public class Document {
	List<String> words;
	
	public long characterCount() {
		long count = this.words
				.stream()
				.mapToLong(w -> w.length())
				.sum();
		
		return count;
	}
	
	public long calculateAvgWordLength() {
		long avgLength = this.characterCount() / this.words.size();
		return avgLength;
	}
// Resto del código que no importa
}
```

### Bad smell: Variables innecesarias
Las variables en los métodos sólo se utilizan para retornar en la siguiente línea. Aplico *Inline Temp*.
```Java
public class Document {
	List<String> words;
	
	public long characterCount() {
		return this.words
				.stream()
				.mapToLong(w -> w.length())
				.sum();
	}
	
	public long calculateAvgWordLength() {
		return this.characterCount() / this.words.size();
	}
// Resto del código que no importa
}
```
### 3. Analice el código original y detecte si existe un problema al calcular las estadísticas. Explique cuál es el error y en qué casos se da ¿El error identificado sigue presente luego de realizar los refactorings? En caso de que no esté presente, ¿en qué momento se resolvió? De acuerdo a lo visto en la teoría, ¿podemos considerar esto un refactoring?
En el caso en el que no haya palabras en el documento, `words.size()` daría 0. En el método para calcular el promedio, podría aparecer una excepción de división por 0. No existe un *bad smell* en el que clasificar esto y el error sigue después de aplicar los refactors.
Para arreglar este error, se puede aplicar la siguiente solución:
```Java
public class Document {
	List<String> words;
	
	public long characterCount() {
		return this.words
				.stream()
				.mapToLong(w -> w.length())
				.sum();
	}
	
	public long calculateAvgWordLength() {
		return (this.words.size() > 0) ?
			this.characterCount() / this.words.size()
			: 0;
	}
// Resto del código que no importa
}
```
Sin embargo, esto no puede ser considerado un refactor, ya que cambia el comportamiento observable del programa. El refactor, por definición, reestructura el código preservando el comportamiento externo.