package ar.edu.unlp.info.oo1.ejercicio15;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class EmailTest {

	Email e1, e2;
	Archivo a1, a2;
	
	@BeforeEach
	void setUp() {
		e1 = new Email("Nombre1", "Cuerpo1");
		e2 = new Email("Nombre2", "Cuerpo2");
		a1 = new Archivo("cinco");
		a2 = new Archivo("seis66");		
		e1.addAdjunto(a1);
		e1.addAdjunto(a2);
	}
	
	@Test
	void testContiene() {
		assertTrue(e1.contiene("Nombre1"));
		assertFalse(e1.contiene("Nombre2"));
	}
	
	@Test
	void testTamanio() {
		assertEquals(25, e1.tamanio());
		assertEquals(14, e2.tamanio());
	}

}
