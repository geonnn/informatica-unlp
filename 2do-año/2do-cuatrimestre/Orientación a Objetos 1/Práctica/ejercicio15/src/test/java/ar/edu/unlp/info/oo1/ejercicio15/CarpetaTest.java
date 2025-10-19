package ar.edu.unlp.info.oo1.ejercicio15;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CarpetaTest {

	Carpeta c1, c2, c3;
	
	@BeforeEach
	void setUp() {
		c1 = new Carpeta("Spam");
		c2 = new Carpeta("Favs");
		c3 = new Carpeta("Favs");
	}
	
	@Test
	void testAgregar() {
		
	}

}
