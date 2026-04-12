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