package ar.edu.unlp.info.oo1.ejercicio15;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ArchivoTest {

	Archivo a;
	
	@BeforeEach
	void setUp() {
		a = new Archivo("cinco");
	}
	
	@Test
	void testTamanio() {
		assertEquals(5, a.tamanio());
	}

}
