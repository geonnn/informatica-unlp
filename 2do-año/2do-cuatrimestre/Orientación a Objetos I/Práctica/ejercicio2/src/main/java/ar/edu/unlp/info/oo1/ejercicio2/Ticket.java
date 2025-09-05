package ar.edu.unlp.info.oo1.ejercicio2;

import java.time.LocalDate;
import java.util.List;

public class Ticket {

	private LocalDate fecha;
	public List<Producto> productos;
	
	public Ticket(List<Producto> productos) {
		this.fecha = LocalDate.now();
		this.productos = productos.stream().map(p -> new Producto(p.getDescripcion(), p.getPeso(), p.getPrecioPorKilo())).toList();
	}
	
	LocalDate getFecha() {
		return fecha;
	}

	int getCantidadDeProductos() {
		return productos.size();
	}

	double getPesoTotal() {
		return productos.stream().mapToDouble(p -> p.getPeso()).sum();
	}
	
	public List<Producto> getProductos() {
		return productos;
	}

	double getPrecioTotal() {
		return productos.stream().mapToDouble(p -> p.getPrecio()).sum();
	}

	double impuesto() {
		return getPrecioTotal() * 0.21;
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