# Ejercicio 7: Etiquetas
```Java
abstract class Etiqueta {
	protected String nombreProducto;
	protected double precio;

	public Etiqueta(String nombre, double precio) {
		this.nombreProducto = nombre;
		this.precio = precio;
	}
}

class EtiquetaSimple extends Etiqueta {
	public EtiquetaSimple(String nombre, double precio) {
		super(nombre, precio);
	}
	
	public void generar() {
		System.out.println("--- ETIQUETA BÁSICA ---");
		System.out.println("Producto: " + nombreProducto);
		System.out.println("Precio: $" + precio);
		System.out.println("-----------------------");
	}
}
	
class EtiquetaDetalle extends Etiqueta {
	public EtiquetaDetalle(String nombre, double precio) {
		super(nombre, precio);
	}
	
	public void generar() {
		System.out.println("--- ETIQUETA DETALLE ---");
		System.out.println("Producto: " + nombreProducto);
		System.out.println("Precio sin imp.: $" + (precio * 0.79));
		System.out.println("Precio final: $" + precio);
		System.out.println("-----------------------");
	}
}
```
**Tareas:**
1. ¿Hay código duplicado? Indique claramente en qué líneas se encuentra.
2. Se quiere aplicar el refactoring Pull Up Method para subir el método generar() a la superclase Etiqueta. ¿Es posible hacerlo en el código anterior? Justifique su respuesta basándose en las precondiciones del refactoring vistas en la teoría y en el libro de Refactoring de Martin Fowler.
3. Mencione los refactorings previos necesarios para que sea posible aplicar Pull Up Method.
4. Aplique Pull Up Method para subir el método generar() a la superclase Etiqueta.

Para aplicar *Pull Up Method* las precondiciones son:
1. Que no exista un método con el mismo nombre en la superclase ✔️
2. Que los métodos sean idénticos ❌

Si los métodos tienen comportamiento similar pero no son idénticos, se puede ajustar la lógica o extraer la lógica distinta para luego poder aplicar *Pull up method*. Aplico *Extract method* sobre los pasos distintos, para que el comportamiento sea idéntico en ambas implementaciones del método `generar()`.

```Java
abstract class Etiqueta {
	protected String nombreProducto;
	protected double precio;

	public Etiqueta(String nombre, double precio) {
		this.nombreProducto = nombre;
		this.precio = precio;
	}
}

class EtiquetaSimple extends Etiqueta {
	public EtiquetaSimple(String nombre, double precio) {
		super(nombre, precio);
	}
	
	public void generar() {
		this.imprimirEncabezado();
		System.out.println("Producto: " + nombreProducto);
		this.imprimirPrecios();
		System.out.println("-----------------------");
	}
	
	private void imprimirEncabezado() {
		System.out.println("--- ETIQUETA BÁSICA ---");
	}
	
	private void imprimirPrecios() {
		System.out.println("Precio: $" + precio);
	}
}
	
class EtiquetaDetalle extends Etiqueta {
	public EtiquetaDetalle(String nombre, double precio) {
		super(nombre, precio);
	}
	
	public void generar() {
		this.imprimirEncabezado();
		System.out.println("Producto: " + nombreProducto);
		this.imprimirPrecios();
		System.out.println("-----------------------");
	}
	
	private void imprimirEncabezado() {
		System.out.println("--- ETIQUETA DETALLE ---");
	}
	
	private void imprimirPrecios() {
		System.out.println("Precio sin imp.: $" + (precio * 0.79));
		System.out.println("Precio final: $" + precio);
	}
}
```
Ahora ya se observa el código duplicado en el método `generar()`, pero este método utiliza métodos implementados en las subclases. Dado que ambas clases lo implementan y es el paso previo para aplicar el *Pull Up Method* para `generar()`, implemento los métodos abstractos en la superclase.
```Java
abstract class Etiqueta {
	protected String nombreProducto;
	protected double precio;

	public Etiqueta(String nombre, double precio) {
		this.nombreProducto = nombre;
		this.precio = precio;
	}
	
	protected abstract void imprimirEncabezado();
	protected abstract void imprimirPrecios();
}

class EtiquetaSimple extends Etiqueta {
	public EtiquetaSimple(String nombre, double precio) {
		super(nombre, precio);
	}
	
	public void generar() {
		this.imprimirEncabezado();
		System.out.println("Producto: " + nombreProducto);
		this.imprimirPrecios();
		System.out.println("-----------------------");
	}
	
	private void imprimirEncabezado() {
		System.out.println("--- ETIQUETA BÁSICA ---");
	}
	
	private void imprimirPrecios() {
		System.out.println("Precio: $" + precio);
	}
}
	
class EtiquetaDetalle extends Etiqueta {
	public EtiquetaDetalle(String nombre, double precio) {
		super(nombre, precio);
	}
	
	public void generar() {
		this.imprimirEncabezado();
		System.out.println("Producto: " + nombreProducto);
		this.imprimirPrecios();
		System.out.println("-----------------------");
	}
	
	private void imprimirEncabezado() {
		System.out.println("--- ETIQUETA DETALLE ---");
	}
	
	private void imprimirPrecios() {
		System.out.println("Precio sin imp.: $" + (precio * 0.79));
		System.out.println("Precio final: $" + precio);
	}
}
```
Finalmente, aplico *Pull Up Method*:
```Java
abstract class Etiqueta {
	protected String nombreProducto;
	protected double precio;

	public Etiqueta(String nombre, double precio) {
		this.nombreProducto = nombre;
		this.precio = precio;
	}
	
	public void generar() {
		this.imprimirEncabezado();
		System.out.println("Producto: " + nombreProducto);
		this.imprimirPrecios();
		System.out.println("-----------------------");
	}
	
	protected abstract void imprimirEncabezado();
	protected abstract void imprimirPrecios();
}

class EtiquetaSimple extends Etiqueta {
	public EtiquetaSimple(String nombre, double precio) {
		super(nombre, precio);
	}
	
	@Override
	private void imprimirEncabezado() {
		System.out.println("--- ETIQUETA BÁSICA ---");
	}
	
	@Override
	private void imprimirPrecios() {
		System.out.println("Precio: $" + precio);
	}
}
	
class EtiquetaDetalle extends Etiqueta {
	public EtiquetaDetalle(String nombre, double precio) {
		super(nombre, precio);
	}
	
	@Override
	private void imprimirEncabezado() {
		System.out.println("--- ETIQUETA DETALLE ---");
	}
	
	@Override
	private void imprimirPrecios() {
		System.out.println("Precio sin imp.: $" + (precio * 0.79));
		System.out.println("Precio final: $" + precio);
	}
}
```