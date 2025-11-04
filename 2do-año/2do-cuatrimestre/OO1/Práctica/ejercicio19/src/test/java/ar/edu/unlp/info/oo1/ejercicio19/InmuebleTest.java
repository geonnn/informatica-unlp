package ar.edu.unlp.info.oo1.ejercicio19;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDate;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import ar.edu.unlp.info.oo1.ejercicio17.DateLapse;

class InmuebleTest {
	
	Inmueble i;
	Usuario u;

	@BeforeEach
	void setUp() {
		i = new Inmueble("depto x", "lp", 100);
		u = new Usuario("guido carrillo", "lp", 22333444);
	}
	
	@Test
	void testIsAvailable() {
		DateLapse dL = new DateLapse(LocalDate.of(2025, 10, 10), LocalDate.of(2025, 11, 10));
		DateLapse dLOcuppied = new DateLapse(LocalDate.of(2025, 10, 20), LocalDate.of(2025, 10, 25));
		DateLapse dLAvailable = new DateLapse(LocalDate.of(2025, 11, 11), LocalDate.of(2025, 11, 20));
		i.addReserva(u, dL);
		assertFalse(i.isAvailable(dLOcuppied));
		assertTrue(i.isAvailable(dLAvailable));
	}
	
	@Test
	void testRemove() {
		DateLapse dL = new DateLapse(LocalDate.of(2025, 11, 1), LocalDate.of(2025, 11, 10));
		i.addReserva(u, dL);
//		assertFalse(i.removeReserva());
	}

}
