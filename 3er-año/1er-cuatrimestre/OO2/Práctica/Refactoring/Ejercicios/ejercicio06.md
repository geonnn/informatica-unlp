# Ejercicio 6:
Para cada una de las siguientes situaciones, realice en forma iterativa los siguientes pasos:
(i) indique el mal olor,
(ii) indique el refactoring que lo corrige,
(iii) aplique el refactoring, mostrando el resultado final (código y/o diseño según corresponda).
Si vuelve a encontrar un mal olor, retorne al paso (i).

## 6.1 Empleados
```Java
public class EmpleadoTemporario {
	public String nombre;
	public String apellido;
	public double sueldoBasico = 0;
	public double horasTrabajadas = 0;
	public int cantidadHijos = 0;
	// ......
	public double sueldo() {
		return this.sueldoBasico
		+​ (this.horasTrabajadas * 500)
		+​ (this.cantidadHijos * 1000)
		-​ (this.sueldoBasico * 0.13);
	}
}
	
public class EmpleadoPlanta {
	public String nombre;
	public String apellido;
	public double sueldoBasico = 0;
	public int cantidadHijos = 0;
	// ......
	public double sueldo() {
		return this.sueldoBasico
		+ (this.cantidadHijos * 2000)
		- (this.sueldoBasico * 0.13);
	}
}

public class EmpleadoPasante {
	public String nombre;
	public String apellido;
	public double sueldoBasico = 0;
	// ......
	public double sueldo() {
		return this.sueldoBasico - (this.sueldoBasico * 0.13);
	}
}
```
### Bad smell: Código duplicado
En las tres clases se observa código duplicado en la declaración de las variables. Podemos aplicar *Pull Up Field* para elevar los atributos comunes a una superclase *Empleado*.
```Java
public abstract class Empleado {
	public String nombre;
	public String apellido
	public double sueldoBasico = 0;
}

public class EmpleadoTemporario extends Empleado {
	public double horasTrabajadas = 0;
	public int cantidadHijos = 0;
	// ......
	public double sueldo() {
		return this.sueldoBasico
		+​ (this.horasTrabajadas * 500)
		+​ (this.cantidadHijos * 1000)
		-​ (this.sueldoBasico * 0.13);
	}
}
	
public class EmpleadoPlanta extends Empleado {
	public int cantidadHijos = 0;
	// ......
	public double sueldo() {
		return this.sueldoBasico
		+ (this.cantidadHijos * 2000)
		- (this.sueldoBasico * 0.13);
	}
}

public class EmpleadoPasante extends Empleado {
	// ......
	public double sueldo() {
		return this.sueldoBasico - (this.sueldoBasico * 0.13);
	}
}
```
### Bad smell: Atributos públicos
Los atributos de la superclase y las subclases están publicos, rompiendo el encapsulamiento. Se puede aplicar el refactoring *Encapsulate Field*, haciendo privados los atributos y creando getters/setters para accederlos. También debemos actualizar las referencias a estos atributos.
```Java
public abstract class Empleado {
	private String nombre;
	private String apellido
	private double sueldoBasico = 0;
	
	public String getNombre() {
		return this.nombre;
	}
	
	public String getApellido() {
		return this.apellido;
	}
	
	public double getSueldoBasico() {
		return this.sueldoBasico;
	}
}

public class EmpleadoTemporario extends Empleado {
	private double horasTrabajadas = 0;
	private int cantidadHijos = 0;
	// ......
	public double sueldo() {
		return this.getSueldoBasico()
		+​ (this.horasTrabajadas * 500)
		+​ (this.cantidadHijos * 1000)
		-​ (this.getSueldoBasico() * 0.13);
	}
}
	
public class EmpleadoPlanta extends Empleado {
	public int cantidadHijos = 0;
	// ......
	public double sueldo() {
		return this.getSueldoBasico()
		+ (this.cantidadHijos * 2000)
		- (this.getSueldoBasico() * 0.13);
	}
}

public class EmpleadoPasante extends Empleado {
	// ......
	public double sueldo() {
		return this.getSueldoBasico() - (this.getSueldoBasico() * 0.13);
	}
}
```
### Bad smell: Código duplicado
Todas las clases poseen el metodo `sueldo()` con parte del código duplicado. Podemos aplicar *Form Template Method*. Este refactoring aplica *Extract Method* para extraer la lógica común y luego *Pull Up Method* para llevar los métodos a la superclase.
```Java
public abstract class Empleado {
	private String nombre;
	private String apellido
	private double sueldoBasico = 0;
	
	public String getNombre() {
		return this.nombre;
	}
	
	public String getApellido() {
		return this.apellido;
	}
	
	public double getSueldoBasico() {
		return this.sueldoBasico;
	}
}

public class EmpleadoTemporario extends Empleado {
	private double horasTrabajadas = 0;
	private int cantidadHijos = 0;
	// ......
	
	
	
	public double sueldo() {
		return this.getSueldoBasico()
		+​ (this.horasTrabajadas * 500)
		+​ (this.cantidadHijos * 1000)
		-​ this.getDescuento();
	}
	
	private double getDescuento() {
		return this.getSueldoBasico() * 0.13;
	}
}
	
public class EmpleadoPlanta extends Empleado {
	public int cantidadHijos = 0;
	// ......
	public double sueldo() {
		return this.getSueldoBasico()
		+ (this.cantidadHijos * 2000)
		- this.getDescuento();
	}
	
	private double getDescuento() {
		return this.getSueldoBasico() * 0.13;
	}
}

public class EmpleadoPasante extends Empleado {
	// ......
	public double sueldo() {
		return this.getSueldoBasico() - this.getDescuento();
	}
	
	private double getDescuento() {
		return this.getSueldoBasico() * 0.13;
	}
}
```
Siguiente paso, elevar el método `getDescuento()`:
```Java
public abstract class Empleado {
	private String nombre;
	private String apellido
	private double sueldoBasico = 0;
	
	public String getNombre() {
		return this.nombre;
	}
	
	public String getApellido() {
		return this.apellido;
	}
	
	public double getSueldoBasico() {
		return this.sueldoBasico;
	}
	
	protected double getDescuento() {
		return this.getSueldoBasico() * 0.13;
	}
}

public class EmpleadoTemporario extends Empleado {
	private double horasTrabajadas = 0;
	private int cantidadHijos = 0;
	// ......
	
	public double sueldo() {
		return this.getSueldoBasico()
		+​ (this.horasTrabajadas * 500)
		+​ (this.cantidadHijos * 1000)
		-​ this.getDescuento();
	}
}
	
public class EmpleadoPlanta extends Empleado {
	public int cantidadHijos = 0;
	// ......
	public double sueldo() {
		return this.getSueldoBasico()
		+ (this.cantidadHijos * 2000)
		- this.getDescuento();
	}
}

public class EmpleadoPasante extends Empleado {
	// ......
	public double sueldo() {
		return this.getSueldoBasico() - this.getDescuento();
	}
}
```
Ahora podemos hacer el template method en la superclase, dejando a las subclases que cada una calculo su propio sueldo final y manteniendo la lógica común en la superclase:
```Java
public abstract class Empleado {
	private String nombre;
	private String apellido
	private double sueldoBasico = 0;
	
	public String getNombre() {
		return this.nombre;
	}
	
	public String getApellido() {
		return this.apellido;
	}
	
	public double getSueldoBasico() {
		return this.sueldoBasico;
	}
	
	public double sueldo() {
		return this.getSueldoBasico()
		+ this.calcularAdicionales()
		- this.getDescuento();
	}
	
	protected double getDescuento() {
		return this.getSueldoBasico() * 0.13;
	}
	
	protected abstract double calcularAdicionales();
}

public class EmpleadoTemporario extends Empleado {
	private double horasTrabajadas = 0;
	private int cantidadHijos = 0;
	
	// ......
	
	protected double calcularAdicionales() {
		return (this.horasTrabajadas * 500)
		+ (this.cantidadHijos * 1000);
	}
}
	
public class EmpleadoPlanta extends Empleado {
	public int cantidadHijos = 0;
	
	// ......
	
	protected double calcularAdicionales() {
		return this.cantidadHijos * 2000;
	}
}

public class EmpleadoPasante extends Empleado {
	// ......
	
	private double calcularAdicionales() {
		return 0;
	}
}
```
### Bad smell: Magic numbers
En el código aparecen números para realizar cálculos y no se puede dar cuenta de a qué refieren. Pueden ser declarados como constantes y utilizarlos desde ahí.
```Java
public abstract class Empleado {
	private String nombre;
	private String apellido
	private double sueldoBasico = 0;
	private static final double porcentajeDescuento = 0.13;
	
	public String getNombre() {
		return this.nombre;
	}
	
	public String getApellido() {
		return this.apellido;
	}
	
	public double getSueldoBasico() {
		return this.sueldoBasico;
	}
	
	public double sueldo() {
		return this.getSueldoBasico()
		+ this.calcularAdicionales()
		- this.getDescuento();
	}
	
	protected double getDescuento() {
		return this.getSueldoBasico() * this.porcentajeDescuento;
	}
	
	protected abstract double calcularAdicionales();
}

public class EmpleadoTemporario extends Empleado {
	private double horasTrabajadas = 0;
	private int cantidadHijos = 0;
	
	private static final double adicionalPorHoraTrabajada = 500;
	private static final double adicionalPorHijo = 1000;
	
	// ......
	
	@Override
	protected double calcularAdicionales() {
		return (this.horasTrabajadas * this.adicionalPorHoraTrabajada)
		+ (this.cantidadHijos * this.adicionalPorHijo);
	}
}
	
public class EmpleadoPlanta extends Empleado {
	public int cantidadHijos = 0;
	
	private final double adicionalPorHijo = 2000;
	
	// ......
	
	@Override
	protected double calcularAdicionales() {
		return this.cantidadHijos * this.AdicionalPorHijo;
	}
}

public class EmpleadoPasante extends Empleado {
	// ......
	
	@Override
	protected double calcularAdicionales() {
		return 0;
	}
}
```
---
## 6.2 Juego
```Java
public class Juego {
	
	// ......
	
	public void incrementar(Jugador j) {
		j.puntuacion = j.puntuacion + 100;
	}
	
	public void decrementar(Jugador j) {
		j.puntuacion = j.puntuacion - 50;
	}
}

public class Jugador {
	public String nombre;
	public String apellido;
	public int puntuacion = 0;
}
```
### Bad smell: Feature envy
La clase Juego utiliza el atributo puntuación del jugador. Jugador debería ser la clase que tiene poder para modificar/leer directamente sobre el atributo puntuación. Se aplica *Move method* y se envía el puntaje por parámetro.
```Java
public class Juego {
	
	// ......
	
	public void incrementar(Jugador j) {
		j.incrementarPuntaje(100);
	}
	
	public void decrementar(Jugador j) {
		j.decrementarPuntaje(50);
	}
}

public class Jugador {
	public String nombre;
	public String apellido;
	public int puntuacion = 0;
	
	public void incrementarPuntaje(int puntos) {
		this.puntuacion += puntos;
	}
	
	public void decrementarPuntaje(int puntos) {
		this.puntuacion -= puntos;
	}
}
```
### Bad smell: Magic numbers
```Java
public class Juego {
	
	private static final int PUNTOS_INCREMENTO = 100;
	private static final int PUNTOS_DECREMENTO = 50;
	
	// ......
	
	public void incrementar(Jugador j) {
		j.incrementarPuntaje(PUNTOS_INCREMENTO);
	}
	
	public void decrementar(Jugador j) {
		j.decrementarPuntaje(PUNTOS_DECREMENTO);
	}
}

public class Jugador {
	public String nombre;
	public String apellido;
	public int puntuacion = 0;
	
	public void incrementarPuntaje(int puntos) {
		this.puntuacion += puntos;
	}
	
	public void decrementarPuntaje(int puntos) {
		this.puntuacion -= puntos;
	}
}
```
### Bad smell: Public field
```Java
public class Juego {
	
	private static final int PUNTOS_INCREMENTO = 100;
	private static final int PUNTOS_DECREMENTO = 50;
	
	// ......
	
	public void incrementar(Jugador j) {
		j.incrementarPuntaje(PUNTOS_INCREMENTO);
	}
	
	public void decrementar(Jugador j) {
		j.decrementarPuntaje(PUNTOS_DECREMENTO);
	}
}

public class Jugador {
	private String nombre;
	private String apellido;
	private int puntuacion = 0;
	
	public void incrementarPuntaje(int puntos) {
		this.puntuacion += puntos;
	}
	
	public void decrementarPuntaje(int puntos) {
		this.puntuacion -= puntos;
	}
	
	public int getPuntuacion() {
		return this.puntuacion;
	}
}
```
---
## 6.3 Publicaciones
![[Pasted image 20261108103903.png]]

```Java
/*
* Retorna los últimos N posts que no pertenecen al usuario user
*/
public List<Post> ultimosPosts(Usuario user, int cantidad) {
	
	List<Post> postsOtrosUsuarios = new ArrayList<Post>();
	for (Post post : this.posts) {
		if (!post.getUsuario().equals(user)) {
			postsOtrosUsuarios.add(post);
		}
	}
	
	// ordena los posts por fecha
	for (int i = 0; i < postsOtrosUsuarios.size(); i++) {
		int masNuevo = i;
		for(int j= i +1; j < postsOtrosUsuarios.size(); j++) {
			if (postsOtrosUsuarios.get(j).getFecha().isAfter(
				postsOtrosUsuarios.get(masNuevo).getFecha())) {
					masNuevo = j;
				}
		}
		Post unPost = postsOtrosUsuarios.set(i,postsOtrosUsuarios.get(masNuevo));
		postsOtrosUsuarios.set(masNuevo, unPost);
	}
	
	List<Post> ultimosPosts = new ArrayList<Post>();
	int index = 0;
	Iterator<Post> postIterator = postsOtrosUsuarios.iterator();
	while (postIterator.hasNext() && index < cantidad) {
		ultimosPosts.add(postIterator.next());
	}
	
	return ultimosPosts;
}
```
### Bad smell: Feature envy
PostApp toma el atributo user de la clase Post y lo usa para realizar la operación de comparación. Se debe aplicar *Move method* y hacer que la clase Post retorne si el post pertenece a un determinado usuario o no.
```Java
/*
* Retorna los últimos N posts que no pertenecen al usuario user
*/
public List<Post> ultimosPosts(Usuario user, int cantidad) {
	
	List<Post> postsOtrosUsuarios = new ArrayList<Post>();
	for (Post post : this.posts) {
		if (!post.perteneceAlUsuario(user)) {
			postsOtrosUsuarios.add(post);
		}
	}
	
	// ordena los posts por fecha
	for (int i = 0; i < postsOtrosUsuarios.size(); i++) {
		int masNuevo = i;
		for(int j = i + 1; j < postsOtrosUsuarios.size(); j++) {
			if (postsOtrosUsuarios.get(j).getFecha().isAfter(
				postsOtrosUsuarios.get(masNuevo).getFecha())) {
					masNuevo = j;
				}
		}
		Post unPost = postsOtrosUsuarios.set(i,postsOtrosUsuarios.get(masNuevo));
		postsOtrosUsuarios.set(masNuevo, unPost);
	}
	
	List<Post> ultimosPosts = new ArrayList<Post>();
	int index = 0;
	Iterator<Post> postIterator = postsOtrosUsuarios.iterator();
	while (postIterator.hasNext() && index < cantidad) {
		ultimosPosts.add(postIterator.next());
	}
	
	return ultimosPosts;
}

// Post.java
public class Post {
	// ...
	public boolean perteneceAlUsuario(Usuario user) {
		return this.getUsuario().equals(user);
	}
	// ...
}
```
### Bad smell: Imperative loop, Comments 
Utiliza una estructura de control for y un iterator para filtrar los posts y para ordenarlos por fecha en lugar de usar la API stream. Hay comentarios sobre qué hace el código que también pueden ser eliminados al hacer el código más legible.
También aplico el refactoring Replace Temp with Query al no necesitar más la variable intermedia de la lista.
```Java
/*
* Retorna los últimos N posts que no pertenecen al usuario user
*/
public List<Post> ultimosPosts(Usuario user, int cantidad) {
	
	return postsOtrosUsuarios.stream()
	.filter(post -> !post.perteneceAlUsuario(user))
	.sorted(Comparator.comparing(Post::getFecha).reversed())
	.limit(cantidad)
	.collect(Collectors.toList());
}

// Post.java
public class Post {
	// ...
	public boolean perteneceAlUsuario(Usuario user) {
		return this.getUsuario().equals(user);
	}
	// ...
}
```
---
## 6.4 Carrito de compras
![[Pasted image 20261108110938.png]]

```Java
public class Producto {
	private String nombre;
	private double precio;
	
	public double getPrecio() {
		return this.precio;
	}
}

public class ItemCarrito {
	private Producto producto;
	private int cantidad;
	
	public Producto getProducto() {
		return this.producto;
	}
	
	public int getCantidad() {
		return this.cantidad;
	}
}

public class Carrito {
	private List<ItemCarrito> items;
	
	public double total() {
		return this.items.stream()
		.mapToDouble(item ->
		item.getProducto().getPrecio() * item.getCantidad())
		.sum();
	}
}
```
### Bad smell: Feature envy / Message chain
La clase Carrito utiliza los atributos de la clase ItemProducto para realizar una operación y obtener el precio total del item (precio producto * cantidad de productos). Esa responsabilidad es de la clase Item, que es quien define esos atributos. Además hay message chain porque le pide el precio al producto que está en la clase item. Se aplica el refactoring *Extract method* para extraer la lógica de la operación y luego *Move method* para llevarlo a la clase a la que pertenece.
```Java
public class Producto {
	private String nombre;
	private double precio;
	
	public double getPrecio() {
		return this.precio;
	}
}

public class ItemCarrito {
	private Producto producto;
	private int cantidad;
	
	public Producto getProducto() {
		return this.producto;
	}
	
	public int getCantidad() {
		return this.cantidad;
	}
}

public class Carrito {
	private List<ItemCarrito> items;
	
	public double total() {
		return this.items.stream()
		.mapToDouble(item -> calcularPrecioItem(item)
		.sum();
	}
	
	private double calcularPrecioItem(Item item) {
		return item.getProducto().getPrecio() * item.getCantidad();
	}
}
```
*Move method* y también podemos quitar getters innecesarios para reducir la superficie de la clase a lo estrictamente necesario:
```Java
public class Producto {
	private String nombre;
	private double precio;
	
	public double getPrecio() {
		return this.precio;
	}
}

public class ItemCarrito {
	private Producto producto;
	private int cantidad;
	
	public double calcularPrecio() {
		return this.producto.getPrecio() * this.cantidad;
	}
}

public class Carrito {
	private List<ItemCarrito> items;
	
	public double total() {
		return this.items.stream()
		.mapToDouble(item -> item.calcularPrecio())
		.sum();
	}
}
```
---
## 6.5 Envío de pedidos
![[Pasted image 20261108113000.png]]
```Java
public class Supermercado {
	public void notificarPedido(long nroPedido, Cliente cliente) {
		String notificacion = MessageFormat.format(
			“Estimado cliente, se le informa que hemos recibido su pedido con número {0}, el cual será enviado a la dirección {1}”, new Object[] { nroPedido, cliente.getDireccionFormateada() });
	// lo imprimimos en pantalla, podría ser un mail, SMS, etc..
	System.out.println(notificacion);
}
	
public class Cliente {
	public String getDireccionFormateada() {
		return this.direccion.getLocalidad() + “, ”
			+ this.direccion.getCalle() + “, ”
			+ this.direccion.getNumero() + “, ”
			+ this.direccion.getDepartamento();
	}
}
```
### Bad smell: Feature envy
La propia clase dirección debe encargarse de usar sus atributos y retornar la "dirección formateada", no el Cliente. Se aplica *Move method*.
```Java
public class Supermercado {
	public void notificarPedido(long nroPedido, Cliente cliente) {
		String notificacion = MessageFormat.format(
			“Estimado cliente, se le informa que hemos recibido su pedido con número {0}, el cual será enviado a la dirección {1}”, new Object[] { nroPedido, cliente.getDireccionFormateada() });
	// lo imprimimos en pantalla, podría ser un mail, SMS, etc..
	System.out.println(notificacion);
}
	
public class Cliente {
	public String getDireccionFormateada() {
		return this.direccion.getDireccionFormateada();
	}
}

public class Direccion {
	public String localidad;
	public String calle;
	public String numero;
	public String departamento;
	// setters, getters, etc...
	public String getDireccionFormateada() {
		return this.getLocalidad() + “, ”
			+ this.getCalle() + “, ”
			+ this.getNumero() + “, ”
			+ this.getDepartamento();
	}
}
```
### Bad smell: Public field
Dirección tiene todos sus atributos públicos, rompiendo el encapsulamiento. Deben hacerse privados. Según el código presentado de la clase Cliente doy por hecho que ya hay getters públicos para estos atributos.
```Java
public class Supermercado {
	public void notificarPedido(long nroPedido, Cliente cliente) {
		String notificacion = MessageFormat.format(
			“Estimado cliente, se le informa que hemos recibido su pedido con número {0}, el cual será enviado a la dirección {1}”, new Object[] { nroPedido, cliente.getDireccionFormateada() });
	// lo imprimimos en pantalla, podría ser un mail, SMS, etc..
	System.out.println(notificacion);
}
	
public class Cliente {
	public String getDireccionFormateada() {
		return this.direccion.getDireccionFormateada();
	}
}

public class Direccion {
	private String localidad;
	private String calle;
	private String numero;
	private String departamento;
	// setters, getters, etc...
	public String getDireccionFormateada() {
		return this.getLocalidad() + “, ”
			+ this.getCalle() + “, ”
			+ this.getNumero() + “, ”
			+ this.getDepartamento();
	}
}
```
### Bad smell: Long method
El método `notificarPedido(...)` realiza dos cosas: arma el mensaje de notificación y también lo envía. Se puede extraer la lógica de armado y envío del mensaje en dos métodos distintos:
```Java
public class Supermercado {
	public void notificarPedido(long nroPedido, Cliente cliente) {
		String notificacion = this.armarMensajeNotificacion(nroPedido, cliente);
		this.enviarNotificacion(notificacion);
	}
	
	private String armarMensajeNotificacion(long nroPedido, Cliente cliente) {
		return MessageFormat.format(
			“Estimado cliente, se le informa que hemos recibido su pedido con número {0}, el cual será enviado a la dirección {1}”,
			new Object[] { nroPedido, cliente.getDireccionFormateada() }
		);
	}
	
	private void enviarNotificacion(String notificacion) {
		// lo imprimimos en pantalla, podría ser un mail, SMS, etc..
		System.out.println(notificacion);
	}
}
	
public class Cliente {
	public String getDireccionFormateada() {
		return this.direccion.getDireccionFormateada();
	}
}

public class Direccion {
	public String localidad;
	public String calle;
	public String numero;
	public String departamento;
	// setters, getters, etc...
	public String getDireccionFormateada() {
		return this.getLocalidad() + “, ”
			+ this.getCalle() + “, ”
			+ this.getNumero() + “, ”
			+ this.getDepartamento();
	}
}
```
### Bad smell: Magic string
Como *Magic numbers* pero con strings. En el método `armarMensajeNotificacion(...)` aparece un string hardcodeado. Es mejor que sea una constante para no tener que tocar un método ejecutable al modificar el mensaje.
También aplico *Replace Temp with Query* para la variable `notificacion` en el método `notificarPedido(...)`. Sólo se utiliza para enviar como parámetro en la siguiente línea.
```Java
public class Supermercado {
	private static final String PLANTILLA NOTIFICACION =
		“Estimado cliente, se le informa que hemos recibido su pedido con número {0}, el cual será enviado a la dirección {1}”;
	
	public void notificarPedido(long nroPedido, Cliente cliente) {
		this.enviarNotificacion(
			this.armarMensajeNotificacion(nroPedido, cliente)
		);
	}
	
	private String armarMensajeNotificacion(long nroPedido, Cliente cliente) {
		return MessageFormat.format(
			PLANTILLA_NOTIFICACION,
			new Object[] { nroPedido, cliente.getDireccionFormateada() }
		);
	}
	
	private void enviarNotificacion(String notificacion) {
		// lo imprimimos en pantalla, podría ser un mail, SMS, etc..
		System.out.println(notificacion);
	}
}
	
public class Cliente {
	public String getDireccionFormateada() {
		return this.direccion.getDireccionFormateada();
	}
}

public class Direccion {
	public String localidad;
	public String calle;
	public String numero;
	public String departamento;
	// setters, getters, etc...
	public String getDireccionFormateada() {
		return this.getLocalidad() + “, ”
			+ this.getCalle() + “, ”
			+ this.getNumero() + “, ”
			+ this.getDepartamento();
	}
}
```
---
## 6.6 Películas
![[Pasted image 20261108115453.png]]

```Java
public class Usuario {
	String tipoSubscripcion;
	// ...
	public void setTipoSubscripcion(String unTipo) {
		this.tipoSubscripcion = unTipo;
	}
	public double calcularCostoPelicula(Pelicula pelicula) {
		double costo = 0;
		
		if (tipoSubscripcion=="Basico") {​
			costo = pelicula.getCosto()
				+ pelicula.calcularCargoExtraPorEstreno();
		}
		else if (tipoSubscripcion== "Familia") {​
			costo = (pelicula.getCosto()
				+ pelicula.calcularCargoExtraPorEstreno()) * 0.90;
		}
		else if (tipoSubscripcion=="Plus") {​
			costo = pelicula.getCosto();
		}
		else if (tipoSubscripcion=="Premium") {​
			costo = pelicula.getCosto() * 0.75;
		}
		
		return costo;
	}
}
public class Pelicula {
	LocalDate fechaEstreno;
	// ...
	public double getCosto() {
		return this.costo;
	}
	
	public double calcularCargoExtraPorEstreno(){
	// Si la Película se estrenó 30 días antes de la fecha actual, retorna un cargo de 0$, caso contrario, retorna un cargo extra de 300$
	return (ChronoUnit.DAYS.between(
				this.fechaEstreno, LocalDate.now()
			)) > 30 ? 0 : 300;
	}
}
```
### Bad smell: Switch statements
Se usan condicionales de forma excesiva. Esto es un mal uso de las herramientas provistas por el lenguaje y deben ser reemplazados por el polimorfismo propio del diseño orientado a objetos. Aplico *Replace Type Code with State/Strategy*.
```Java
public class Usuario {

	private String nombre;
	private int telefono;
	private String email;
	private Suscripcion suscripcion;
	
	private void setTipoSuscripcion(Suscripcion suscripcion) {
		this.suscripcion = suscripcion;
	}
	
	public double calcularCostoPelicula(Pelicula pelicula) {
		return this.suscripcion.calcularCostoPelicula(pelicula);
	}
	
}

public abstract class Suscripcion {
	
	public double calcularCostoPelicula(Pelicula pelicula) {
		return (pelicula.getCosto()
			+ this.cargoExtra(pelicula))
			* this.descuento();
	}
	
	protected double cargoExtra(Pelicula pelicula) {
		return 0;
	}
	
	protected double descuento() {
		return 1.0;
	}
}

public class SuscripcionBasica extends Suscripcion {
	
	@Override
	public double cargoExtra(Pelicula pelicula) {
		return pelicula.calcularCargoExtraPorEstreno();
	}
	
}

public class SuscripcionFamilia extends Suscripcion {
	
	@Override
	public double cargoExtra(Pelicula pelicula) {
		return pelicula.calcularCargoExtraPorEstreno();
	}
	
	@Override
	public double descuento() {
		return 0.90;
	}
	
}

public class SuscripcionPlus extends Suscripcion {	
}

public class SuscripcionPremium extends Suscripcion {
	
	@Override
	public double descuento() {
		return 0.75;
	}
}

public class Pelicula {
	LocalDate fechaEstreno;
	// ...
	public double getCosto() {
		return this.costo;
	}
	
	public double calcularCargoExtraPorEstreno(){
	// Si la Película se estrenó 30 días antes de la fecha actual, retorna un cargo de 0$, caso contrario, retorna un cargo extra de 300$
	return (ChronoUnit.DAYS.between(
				this.fechaEstreno, LocalDate.now()
			)) > 30 ? 0 : 300;
	}
}
```
Sobre el método `cargoExtra(...)`:
- Caso base en 0: se puede justificar que se utiliza el elemento neutro de la suma 
  como hook por defecto.
- Método abstracto: se puede justificar que la política de recargo es una decisión
  explícita de cada plan de suscripción que no debe asumirse a nivel general.
### Bad smell: Long method/comments/magic numbers
En la clase Pelicula, el método `calcularCargoExtraPorEstreno()` retorna el cargo extra por estreno y además calcula si la película efectivamente es estreno. Aplico *Extract Method* borro el comentario y reemplazo los números sueltos por constantes comunicativas:
```Java
public class Usuario {

	private String nombre;
	private int telefono;
	private String email;
	private Suscripcion suscripcion;
	
	public void setTipoSuscripcion(Suscripcion suscripcion) {
		this.suscripcion = suscripcion;
	}
	
	public double calcularCostoPelicula(Pelicula pelicula) {
		return this.suscripcion.calcularCostoPelicula(pelicula);
	}
	
}

public abstract class Suscripcion {
	
	public double calcularCostoPelicula(Pelicula pelicula) {
		return (pelicula.getCosto()
			+ this.cargoExtra(pelicula))
			* this.descuento();
	}
	
	protected double cargoExtra(Pelicula pelicula) {
		return 0;
	}
	
	protected double descuento() {
		return 1.0;
	}
}

public class SuscripcionBasica extends Suscripcion {
	
	@Override
	public double cargoExtra(Pelicula pelicula) {
		return pelicula.calcularCargoExtraPorEstreno();
	}
	
}

public class SuscripcionFamilia extends Suscripcion {
	
	@Override
	public double cargoExtra(Pelicula pelicula) {
		return pelicula.calcularCargoExtraPorEstreno();
	}
	
	@Override
	public double descuento() {
		return 0.90;
	}
	
}

public class SuscripcionPlus extends Suscripcion {	
}

public class SuscripcionPremium extends Suscripcion {
	
	@Override
	public double descuento() {
		return 0.75;
	}
}

public class Pelicula {
	LocalDate fechaEstreno;
	private static final int DIAS_CONSIDERAR_ESTRENO = 30;
	private static final int CARGO_EXTRA_ESTRENO = 300;
	// ...
	
	public double getCosto() {
		return this.costo;
	}
	
	private boolean esEstreno() {
		return ChronoUnit.DAYS.between(this.fechaEstreno, LocalDate.now())
				<= DIAS_CONSIDERAR_ESTRENO;
	}
	
	public double calcularCargoExtraPorEstreno(){
		return esEstreno() ? CARGO_EXTRA_ESTRENO : 0;
	}
}
```