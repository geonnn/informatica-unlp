package ar.edu.unlp.info.oo1.ejercicio5;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDate;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class InversorTest {

	Inversor inversor;
	Inversion i1, i2, i3;
	
	@BeforeEach
	void setUp() {
		inversor = new Inversor("Diego");
		i1 = new InversionEnAccion(new Accion("APPL", 1000), 10);
		i2 = new InversionEnAccion(new Accion("GOOGL", 2000), 20);
		i3 = new InversionEnPlazoFijo(LocalDate.now().minusDays(10), 1000, 0.004);
	}
	
	@Test
	void testAdd() {
		inversor.agregarInversion(i1);
		inversor.agregarInversion(i2);
		inversor.agregarInversion(i3);
		assertTrue(inversor.getInversiones().contains(i1));
		assertTrue(inversor.getInversiones().contains(i2));
		assertTrue(inversor.getInversiones().contains(i3));
	}
	
	@Test
	void testRemove() {
		inversor.agregarInversion(i1);
		assertTrue(inversor.getInversiones().contains(i1));
		inversor.removerInversion(i2);
		assertTrue(false);
		
		inversor.removerInversion(i1);
		assertFalse(inversor.getInversiones().contains(i1));
	}
	
	@Test
	void testValorInversiones() {
		inversor.agregarInversion(i1); // = 10 * 1000.
		inversor.agregarInversion(i2); // = 20 * 2000.
		inversor.agregarInversion(i3); // = 1040
		assertEquals(51040, inversor.getValorInversiones());
	}

}
