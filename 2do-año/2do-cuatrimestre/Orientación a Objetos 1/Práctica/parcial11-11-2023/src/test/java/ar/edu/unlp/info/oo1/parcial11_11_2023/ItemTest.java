package ar.edu.unlp.info.oo1.parcial11_11_2023;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class ItemTest {
	
	Producto p1, p2;
	Item i1,i2, i3, i4;
	
	@BeforeEach
	void setUp() {
		p1 = new ProductoNacional("Yogurt", 1000, "La Serenísima");
		p2 = new ProductoImportado("Café", 1000, "La Morenita", "Brasil");
		i1 = new Item(p1, 10);
		i2 = new Item(p1, 15);
		i3 = new Item(p2, 50);
		i4 = new Item(p2, 51);
	}
	
	@Test
	void testGetCosto() {
		assertEquals(10050, i1.getCosto()); // 5% de $1000(p.u.) = $50.
		assertEquals(15000, i2.getCosto()); // sin impuesto.
		
		assertEquals(50210, i3.getCosto()); // 21% de $1000 = $210.
		assertEquals(51080, i4.getCosto()); // 8% de $1000 = $80.
	}

}
