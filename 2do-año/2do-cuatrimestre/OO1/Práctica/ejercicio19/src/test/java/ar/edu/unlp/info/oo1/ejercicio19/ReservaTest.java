package ar.edu.unlp.info.oo1.ejercicio19;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDate;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import ar.edu.unlp.info.oo1.ejercicio17.DateLapse;

class ReservaTest {
	
	Reserva r;
	Usuario u;
	Inmueble i;
	DateLapse dl;
	
	@BeforeEach
	void setUp() {
		u = new Usuario("juan", "lp", 11222333);
		i = new Inmueble("depto x", "lp", 1000);
		dl = new DateLapse(LocalDate.of(2025, 10, 10), LocalDate.of(2025, 10, 20));
		r = new Reserva(u, i, dl);
	}

	@Test
	void testPrecio() {
		assertEquals(i.getPrecioPNoche()*dl.sizeInDays(), r.getPrecio());
	}
	
	@Test
	void testCoincidencias() {
		DateLapse dl1 = new DateLapse(LocalDate.of(2025, 9, 1), LocalDate.of(2025, 12, 30));
		DateLapse dl2 = new DateLapse(LocalDate.of(2025, 10, 15), LocalDate.of(2025, 10, 24));
		
		assertEquals(11, r.getCoincidencias(dl1));
		assertEquals(6, r.getCoincidencias(dl2));
	}

}
