package ar.edu.unlp.info.oo1.ejercicio29;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class PlanGrupalTest {

	private PlanGrupal p;
	
	@BeforeEach
	void setUp() {
		p = new PlanGrupal(3);
	}

	@Test
	void testCalcularPenalizacion() {
		assertEquals(0, p.calcularPenalizacion(3, 5)); // usedIps <= ipLimit. todo ok. antigüedad es irrelevante.
		assertEquals(0, p.calcularPenalizacion(4, 11)); // usedIps > ipLimit. 1 * 500. antigüedad cancela la penalización. 
		assertEquals(500, p.calcularPenalizacion(4, 1)); // usedIps > ipLimit. 1 * 500. antigüedad no alcanza para cancelar. 
	}
	
}
