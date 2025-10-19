package ar.edu.unlp.info.oo1.parcial11_11_2023;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class ProductoImportadoTest {
	
	ProductoImportado p1, p2;
	
	@BeforeEach
	void setUp() {
		p1 = new ProductoImportado("Café", 1000, "La morenita", "Brasil");
		p2 = new ProductoImportado("Samsung A33", 1000, "Samsung", "Corea del Sur");
	}
	
	@Test
	void testImpuesto() {
		assertEquals(0.21, p1.getImpuesto(1));
		assertEquals(0.21, p2.getImpuesto(1));
		
		assertEquals(0.21, p1.getImpuesto(50));
		assertEquals(0.21, p2.getImpuesto(50));
		
		assertEquals(0.08, p1.getImpuesto(51));
		assertEquals(0.21, p2.getImpuesto(51));
	}
}
