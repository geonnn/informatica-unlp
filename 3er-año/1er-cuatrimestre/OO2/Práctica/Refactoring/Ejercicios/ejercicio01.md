# Ejercicio 1: Algo huele mal
Indique qué malos olores se presentan en los siguientes ejemplos.

---
## 1.1 Protocolo de Cliente
La clase Cliente tiene el siguiente protocolo. ¿Cómo puede mejorarlo?

```java
/** 
* Retorna el límite de crédito del cliente
*/
public double lmtCrdt() {...

/** 
* Retorna el monto facturado al cliente desde la fecha f1 a la fecha f2
*/
protected double mtFcE(LocalDate f1, LocalDate f2) {...

/** 
* Retorna el monto cobrado al cliente desde la fecha f1 a la fecha f2
*/
private double mtCbE(LocalDate f1, LocalDate f2) {...

```
#### Bad smell: Uncommunicative name
Métodos con nombre no comunicativo o poco explicativo. Provocan comentarios innecesarios para explicar su uso o funcionalidad.
#### Solución: Renombrar los métodos
```java
public double getLimiteCredito() {...}
protected double getMontoFacturadoEntreFechas(LocalDate f1, LocalDate f2) {...}
private double getMontoCobradoEntreFechas(LocalDate f1, LocalDate f2) {...}
```

#### Bad smell: Uncommunicative name
Parámetros con nombre poco explicativo.
#### Solución: Renombrar parámetros
```java
protected double getMontoFacturadoCliente(LocalDate fechaInicio f1, LocalDate fechaFin f2) {...}
private double getMontoCobradoEntreFechas(LocalDate fechaInicio f1, LocalDate fechaFin f2) {...}
```
---
## 1.2 Participación en proyectos
Al revisar el siguiente diseño inicial (Figura 1), se decidió realizar un cambio para evitar lo que se consideraba un mal olor. El diseño modificado se muestra en la Figura 2. Indique qué tipo de cambio se realizó y si lo considera apropiado. Justifique su respuesta.

**Diseño inicial:**
![[Pasted image 20260408122025.png]]  
Figura 1: Diagrama de clases del diseño inicial. 

**Diseño revisado:**
![[Pasted image 20260408122108.png]]
Figura 2: Diagrama de clases modificado.

#### Bad smell: Feature envy
Se detectó este bad smell porque la clase Persona utilizaba un atributo de la clase proyecto (la lista de participantes) que no le correspondía. Además la clase responsable de saber si una persona participa en un proyecto debería ser Proyecto.
La modificación es correcta. Se mueve el método a la clase Proyecto y se modifica para que verifique si una persona participa de ese proyecto.

#### Bad smell: Public field
La clase Persona tiene la variable de instancia `id` declarada como pública, rompiendo el encapsulamiento.

#### Solución: Modificar la visibilidad
```java
private int id;
```

## 1.3 Cálculos

Analice el código que se muestra a continuación. Indique qué code smells encuentra y cómo pueden corregirse.​​​

```java
public void imprimirValores() {
	int totalEdades = 0;
	double promedioEdades = 0;
	double totalSalarios = 0;

	for (Empleado empleado : personal) {
		totalEdades = totalEdades + empleado.getEdad();
		totalSalarios = totalSalarios + empleado.getSalario();
	}
	promedioEdades = totalEdades / personal.size();
	
	String message = String.format("El promedio de las edades es %s y el total de salarios es %s", promedioEdades, totalSalarios);
	
	System.out.println(message);
}
```
#### Bad smell: _Uncommunicative name_
El nombre del método `imprimirValores()` no comunica de manera correcta lo que hace.

#### Solución: aplicar _Rename method_
```java
public void imprimirPromedioEdadesYTotalSalarios() {...}
```

#### Bad smell: _Imperative loops_
Utiliza una estructura `for` para calcular el total de edad de los empleados, cuando esto puede ser realizado con la API Stream.

#### Solución: utilizar la API Stream
```java
totalEdades = personal.stream().mapToDouble(e -> e.getEdad()).sum();
```
Lo mismo ocurre con salarios:
```java
totalSalarios = personal.stream().mapToDouble(e -> e.getSalario()).sum();
```
Y dado que `totalEdades` no se utiliza para otra cosa que para calcular el promedio, se puede calcular el promedio directamente con la API Stream.
```java
promedioEdades = personal.stream().mapToDouble(e -> e.getEdad()).average();
```
#### Resultado hasta ahora:
 ```java
public void imprimirPromedioEdadesYTotalSalarios() {
	double promedioEdades = personal.stream().mapToDouble(e -> e.getEdad()).average();
	double totalSalarios = personal.stream().mapToDouble(e -> e.getSalario()).sum();
	
	String message = String.format("El promedio de las edades es %s y el total de salarios es %s", promedioEdades, totalSalarios);
	
	System.out.println(message);
}
 ```

#### Bad smell: _Long method_
El método `imprimirPromedioEdadesYTotalSalarios()` tiene más de una responsabilidad, no sólo imprime sino que también calcula.

#### Solución: aplicar _Extract method_
Extraemos la lógica de cálculo de promedio de edades y total de salarios en nuevos métodos.
```java
public void imprimirPromedioEdadesYTotalSalarios() {	
	promedioEdades = calcularPromedioEdades();
	totalSalarios = calcularTotalSalarios();
	
	String message = String.format("El promedio de las edades es %s y el total de salarios es %s", promedioEdades, totalSalarios);
	
	System.out.println(message);
}

private double calcularPromedioEdades() {
	return personal.stream().mapToDouble(e -> e.getEdad()).average();
}

private double calcularTotalSalarios() {
	return personal.stream().mapToDouble(e -> e.getSalario()).sum();
}
```

#### Bad smell: uso de variables temporales innecesarias
Las variables `promedioEdades` y `totalSalarios` sólo se utilizan para imprimir y pueden ser eliminadas.
#### Solución: aplicar _Replace temp with query_
```java
public void imprimirPromedioEdadesYTotalSalarios() {	
	String message = String.format(
		"El promedio de las edades es %s y el total de salarios es %s",
		calcularPromedioEdades(), calcularTotalSalarios());
	
	System.out.println(message);
}

private double calcularPromedioEdades() {
	return personal.stream().mapToDouble(e -> e.getEdad()).average();
}

private double calcularTotalSalarios() {
	return personal.stream().mapToDouble(e -> e.getSalario()).sum();
}
```