package ar.edu.unlp.info.oo1.ejercicio29;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class PlanIndividualTest {
	
	private PlanIndividual p;
	
	@BeforeEach
	void setUp() {
		p = new PlanIndividual(100);
	}

	@Test
	void testCalcularPenalizacion() {
		assertEquals(0, p.calcularPenalizacion(1, 0)); // una ip = todo ok
		assertEquals(300, p.calcularPenalizacion(2, 0)); // dos ips = una ip de más, 1 * 300.
	}
}
