package ar.edu.unlp.info.oo1.ejercicio11;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class CuentaTest {
	
	Cuenta caja1, caja2, cc1, cc2;

	@BeforeEach
	void setUp() throws Exception {
		caja1 = new CajaDeAhorro();
		caja2 = new CajaDeAhorro();
		cc1 = new CuentaCorriente();
		cc2 = new CuentaCorriente();
	}
	
	@Test
	void testDepositar() {
		caja1.depositar(1000);
		assertEquals(1000, caja1.getSaldo());
		cc1.depositar(1000);
		assertEquals(1000, cc1.getSaldo());
	}
	
	@Test
	void testPuedeExtraer() {
		caja1.depositar(100);
		assertTrue(caja1.puedeExtraer(50));
		assertFalse(caja1.puedeExtraer(100)); // 100 * 1.02 = 102.
		
		cc1.depositar(100);
		assertTrue(cc1.puedeExtraer(100));
		assertFalse(cc1.puedeExtraer(200));
	}
	
	@Test
	void testExtraer() {
		caja1.depositar(200);
		assertTrue(caja1.extraer(100));
		assertEquals(98, caja1.getSaldo()); // 200 - (100 * 1.02) = 98.
	}
	
	@Test
	void testTransferir() {
		caja1.depositar(200);
		assertTrue(caja1.transferirACuenta(100, caja2));
		assertEquals(100, caja2.getSaldo());
		assertEquals(98, caja1.getSaldo());
	}
}
