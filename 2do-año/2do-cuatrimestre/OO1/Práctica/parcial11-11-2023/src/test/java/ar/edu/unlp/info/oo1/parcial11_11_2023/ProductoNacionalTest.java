package ar.edu.unlp.info.oo1.parcial11_11_2023;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class ProductoNacionalTest {

	ProductoNacional p;
	
	@BeforeEach
	void setUp() {
		p = new ProductoNacional("Yogurt", 1000, "La serenísima");
	}
	
	@Test
	void testImpuesto() {
		assertEquals(0.05, p.getImpuesto(1));
		assertEquals(0.05, p.getImpuesto(10));
		assertEquals(0, p.getImpuesto(11));
	}
}
