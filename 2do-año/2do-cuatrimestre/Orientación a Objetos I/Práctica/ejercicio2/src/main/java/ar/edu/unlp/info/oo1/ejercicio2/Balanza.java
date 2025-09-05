package ar.edu.unlp.info.oo1.ejercicio2;

import java.util.LinkedList;
import java.util.List;

public class Balanza {
	
	private List<Producto> productos; // ej. 4
	
	public Balanza() {		
		productos = new LinkedList<Producto>(); // ej. 4
		ponerEnCero();
	}
	
	double getCantidadDeProductos() {
		return productos.size();
	}
	
	double getPrecioTotal() {
		return productos.stream().mapToDouble(p -> p.getPrecio()).sum();
	}
	
	double getPesoTotal() {
		return productos.stream().mapToDouble(p -> p.getPeso()).sum();
	}
	
	public List<Producto> getProductos() {
		return productos;
	}
	
	void ponerEnCero() {
		productos.clear(); // ej. 4
		// cantidadDeProductos = 0;
		// pesoTotal = 0;
	}

	void agregarProducto(Producto producto) {
		// cantidadDeProductos += 1;
		productos.add(producto); // ej. 4
		// pesoTotal += producto.getPeso();
	}
	
	Ticket emitirTicket() {
		return new Ticket(productos);
	}
}

// Ejercicio 4:

// ¿Qué cambio produce este nuevo requerimiento en la implementación del mensaje ponerEnCero()?
// ponerEnCero() ahora también vacía la lista de productos.

// ¿Es necesario, ahora, almacenar los totales en la balanza? ¿Se pueden obtener estos valores de otra forma?
// Los totales se podrían sacar iterando los productos desde la lista.

