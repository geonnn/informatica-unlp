# Ejercicio 5: Productos
> Se cuenta con un sistema que maneja una jerarquía de productos que pueden ser estadías de hoteles o alquileres de autos. En el siguiente material adicional puede descargar un proyecto con las clases implementadas. Observe que el proyecto cuenta con test unitarios que verifican el funcionamiento correcto de la aplicación. A continuación se muestra un extracto del código:

```java
public class HotelStay extends Product {
	public double cost;
	private TimePeriod timePeriod;
	private Hotel hotel;
	
	public HotelStay(double cost, TimePeriod timePeriod, Hotel hotel) {
		this.cost = cost;
		this.timePeriod = timePeriod;
		this.hotel = hotel;
	}
	
	public LocalDate startDate() {
		return this.timePeriod.start();
	}
	
	public LocalDate endDate() {
		return this.timePeriod.end();
	}
	
	public double priceFactor() {
		return this.cost / this.price();
	}
	
	public double price() {
		return this.timePeriod.duration() * this.hotel.nightPrice() * this.hotel.discountRate();
	}
```

```java
public class CarRental extends Product {
	public double cost;
	private TimePeriod timePeriod;
	private Company company;
	
	public CarRental(double cost, TimePeriod timePeriod, Company company) {
		this.cost = cost;
		this.timePeriod = timePeriod;
		this.company = company;
	}
	
	public LocalDate startDate() {
		return this.timePeriod.start();
	}
	
	public LocalDate endDate() {
		return this.timePeriod.end();
	}
	
	public double price() {
		return this.company.price() * this.company.promotionRate();
	}
	
	public double cost() {
		return this.cost;
	}
}

```

Tareas:
1. La variable “cost” está declarada como pública, lo que rompe el encapsulamiento de la clase. Utilice el refactoring Encapsulate Field y describa brevemente los pasos llevados a cabo. Verifique que los tests provistos sigan funcionando.
   Discuta con un ayudante:
   a. ¿Es correcto modificar alguno de los tests para que el código refactorizado funcione?
   b. En caso de qué el test falle, ¿qué situación está representando este test?
#### Encapsulate Field `cost`
- Se establecen métodos getter y setter. La clase ya tenía un método `cost()` que se comportaba como un getter, así que lo renombro a `getCost()` y lo utilizo como el getter para este refactoring.
- Cambiar todas las referencias a este campo por los métodos getter y setter según corresponda. En este paso se modifica el test, ya que usaba `cost` como campo y ahora debe usar `getCost()`.
- Se hace privado el campo.
- Compilar y testear.


2. Utilice el refactoring Rename Field en el método priceFactor(), para que la variable “cost” se pase a llamar “quote”. Verifique que los tests provistos sigan funcionando.
   Discuta con un ayudante: ¿en este caso, es necesario modificar alguno de los tests para que el código refactorizado funcione?
#### Rename Field `cost` -> `quote`
- Se renombra `cost` a `quote`.
- En los tests se utiliza el campo público `cost`. Que este campo sea público rompe el encapsulamiento de la clase. Al renombrarlo, provoca que los test fallen porque el campo `cost` no existe.
- Luego del refactor Rename Field, se debe aplicar Encapsulate Field de una forma similar a como fue aplicado en el punto anterior, logrando el encapsulamiento de la clase.

3. Se quiere aplicar el refactoring Pull Up Method para subir los métodos startDate() y endDate() a la superclase Product. ¿Es posible hacerlo en el código anterior? Justifique su respuesta basándose en las precondiciones del refactoring vistas en la teoría y en el libro de Refactoring de Martin Fowler.
#### Pull Up Method
El refactor Pull Up Method requiere como precondición que los métodos sean idénticos (incluyendo la firma). Si no lo son, se deben aplicar otros refactors previos para hacer que la precondición se cumpla.
No se puede realizar Pull Up Method directamente ya que el método utiliza un field presente en las subclases.

4. Mencione y aplique los refactorings necesarios para poder hacer Pull Up Method.
- Pull Up Field de `timePeriod`.
- Compilar y testear ✅.
Clase `Product` original:
```java
public class Product {
}
```

Clase `Product` resultante:
```java
public abstract class Product {
    protected TimePeriod timePeriod;
}
```

5. Aplique Pull Up Method para subir los métodos a la superclase Product. Verifique que los tests provistos sigan funcionando.
Ahora sí, se puede aplicar Pull Up Method.
```java
public abstract class Product {
    protected TimePeriod timePeriod;

    protected LocalDate startDate() {
        return this.timePeriod.start();
    }

    protected LocalDate endDate() {
        return this.timePeriod.end();
    }
}
```

6. Observe los métodos price() en CarRental.java (línea 21) y en HotelStay.java (línea 25). Identifique los Code Smell presentes. Luego aplique los refactoring correspondientes para eliminarlos. Verifique que los tests provistos sigan funcionando.