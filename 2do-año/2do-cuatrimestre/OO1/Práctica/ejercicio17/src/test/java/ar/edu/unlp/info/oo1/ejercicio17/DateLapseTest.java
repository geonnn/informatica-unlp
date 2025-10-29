package ar.edu.unlp.info.oo1.ejercicio17;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class DateLapseTest {

	DateLapse dl;
	LocalDate ld1, ld2, ldOut;
	
	@BeforeEach
	void setUp() {
		ld1 = LocalDate.of(1972, 12, 15);
		ld2 = LocalDate.of(2032, 12, 15);
		ldOut = LocalDate.of(2032, 12, 16);
		dl = new DateLapse(ld1, ld2);
	}
	
	@Test
	void testSizeInDays() {
		assertEquals(dl.sizeInDays(), ChronoUnit.DAYS.between(ld1, ld2));
	}
	
	// no especifica si es con bordes incluidos o no.
	@Test
	void testIncludesDate() {
		assertTrue(dl.includesDate(ld1));
		assertFalse(dl.includesDate(ldOut));
	}
	
	@Test
	void testCoincidencias() {
		LocalDate ld3 = LocalDate.of(2032, 12, 10);
		LocalDate ld4 = LocalDate.of(2032, 12, 18);
		DateLapse dl2 = new DateLapse(ld3, ld4);
		assertEquals(6, dl.coincidencias(dl2));
		
		LocalDate ld5 = LocalDate.of(1972, 12, 10);
		LocalDate ld6 = LocalDate.of(1972, 12, 20);
		DateLapse dl3 = new DateLapse(ld5, ld6);
		assertEquals(6, dl.coincidencias(dl3));
	}
}
