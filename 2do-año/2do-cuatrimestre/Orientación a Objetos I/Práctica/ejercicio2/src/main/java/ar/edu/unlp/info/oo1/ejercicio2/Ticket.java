package ar.edu.unlp.info.oo1.ejercicio2;

import java.time.LocalDate;
import java.util.LinkedList;
import java.util.List;

public class Ticket {

	private LocalDate fecha;
	private int cantidadDeProductos;
	private double pesoTotal;
	private double precioTotal;
	public List<Producto> productos;
	
	public Ticket(int cantidadDeProductos, double pesoTotal, List<Producto> productos) {
		this.fecha = LocalDate.now();
		this.cantidadDeProductos = cantidadDeProductos;
		this.pesoTotal = pesoTotal;
		this.productos = new LinkedList<Producto>();
		this.productos.addAll(productos);
		this.precioTotal = calcularPrecioTotal();
	}
	
	LocalDate getFecha() {
		return fecha;
	}

	int getCantidadDeProductos() {
		return cantidadDeProductos;
	}

	double getPesoTotal() {
		return pesoTotal;
	}
	
	public List<Producto> getProductos() {
		return productos;
	}

	double getPrecioTotal() {
		return precioTotal;
	}

	double impuesto() {
		return getPrecioTotal() * 0.21;
	}
	
	private double calcularPrecioTotal() {
		double total = 0;
		for (Producto producto : productos) {
			total += producto.getPrecio();
		}
		return total;
	}
}

// Ejercicio 4:

// ¿Qué cambios cree necesarios en Ticket para que pueda conocer a los productos?
// El constructor ahora recibe la lista de productos.

// ¿Estos cambios modifican las responsabilidades ya asignadas de realizar cálculo del precio total?.
// ¿El ticket adquiere nuevas responsabilidades que antes no tenía?
// El ticket ahora también podría calcular el precio total de los productos, antes lo hacía sólo la balanza.
// De todas formas el ticket podría seguir manteniendo una variable de precio total que se asigna al momento de ser emitido.

// Después de hacer estos cambios, ¿siguen pasando los tests? ¿Está bien que sea así?
// Hay un test que prueba cambiar los precios de los productos una vez emitido el ticket.
// Si el precio total se calcula al ser emitido (en el momento de construcción) y se almacena este problema se soluciona.
// También podría recibirlo por parámetro desde la balanza y evitar el cálculo.
// Igualmente los productos en la lista tendrán su precio modificado, pero el precio total se mantiene intacto desde el momento de emisión del ticket.