package ar.edu.unlp.info.oo1.ejercicio11;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class CuentaCorrienteTest {
	
	CuentaCorriente cc1, cc2;
	
	@BeforeEach
	void setUp() {
		cc1 = new CuentaCorriente();
		cc2 = new CuentaCorriente();
	}
	
	@Test
	void testDepositar() {
		cc1.depositar(1000);
		assertEquals(1000, cc1.getSaldo());
	}
	
	@Test
	void testPuedeExtraer() {
		cc1.depositar(100);
		cc1.setDescubierto(50);
		assertTrue(cc1.puedeExtraer(50));
		assertTrue(cc1.puedeExtraer(125));
		assertFalse(cc1.puedeExtraer(200));
	}
	
	@Test
	void testExtraer() {
		cc1.depositar(200);
		assertTrue(cc1.extraer(100));
		assertEquals(100, cc1.getSaldo());
	}
	
	@Test
	void testTransferir() {
		cc1.depositar(200);
		assertTrue(cc1.transferirACuenta(100, cc2));
		assertEquals(100, cc2.getSaldo());
		assertEquals(100, cc1.getSaldo());
	}
}

