package ar.edu.unlp.info.oo1.parcial11_11_2023;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.LocalDate;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class PedidoTest {
	
	Pedido pe;
	Producto p1;
	Item i1;
	
	@BeforeEach
	void setUp() {
		p1 = new ProductoNacional("Yogurt", 1000, "La Serenísima");
		i1 = new Item(p1, 11);
		pe = new Pedido(new Cliente("Gonzalo", "gonzalo@g", LocalDate.now()), LocalDate.now());
	}
	
	@Test
	void testAgregarItems() {
		Item i2 = new Item(new ProductoImportado("Café", 1000, "La Morenita", "Brasil"), 20);
		pe.agregarItem(i1);
		pe.agregarItem(i2);
		assertTrue(pe.getItems().contains(i1));
		assertTrue(pe.getItems().contains(i2));
	}
	
	@Test
	void testCantidadProducto() {
//		Producto p = new ProductoNacional("Yogurt", 1000, "La Serenísima");
//		si el producto no es la misma instancia no funciona, por el equals de Producto.
//		habría que redefinirlo?
		pe.agregarItem(i1);
		assertEquals(11, pe.getCantidadProducto(p1));
	}

	@Test
	void testCostoTotal() {
		Item i2 = new Item(new ProductoImportado("Café", 1000, "La Morenita", "Brasil"), 20);
		pe.agregarItem(i1);
		pe.agregarItem(i2);
		assertEquals(i1.getCosto()+i2.getCosto(), pe.getCostoTotal());
	}
}
