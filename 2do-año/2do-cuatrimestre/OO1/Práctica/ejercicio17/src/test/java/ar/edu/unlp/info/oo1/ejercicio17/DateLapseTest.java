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
		dl = new DateLapse();
		dl.setFrom(ld1);
		dl.setTo(ld2);
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
}
