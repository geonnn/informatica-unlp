package ar.edu.unlp.info.oo1.ejercicio18;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class EvenNumberSetTest {

	EvenNumberSet<Integer> numbers;
	
	@BeforeEach
	void setUp() {
		numbers = new EvenNumberSet<>();
	}
	
	@Test
	void test() {
		assertTrue(numbers.add(2));
		assertTrue(numbers.add(4));
		assertFalse(numbers.add(2));
		assertFalse(numbers.add(1));
	}

}
