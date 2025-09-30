package ar.edu.unlp.info.oo1.ejercicio14;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ReporteDeConstruccionTest {
	
	ReporteDeConstruccion reporte;
	Pieza p1, p2, p3;
	

	@BeforeEach
	void setUp() {
		reporte = new ReporteDeConstruccion();
		p1 = new Cilindro("Hierro", "Rojo", 5, 10);
		p2 = new Esfera("Plomo", "Rojo", 10);
		p3 = new PrismaRectangular("Hierro", "Azul", 10, 5, 8);
		reporte.addPieza(p1);
		reporte.addPieza(p2);
		reporte.addPieza(p3);
	}
	
	@Test
	void testVolumen() {
		assertEquals(p1.getVolumen() + p3.getVolumen(), reporte.volumenDeMaterial("Hierro"));
	}
	
	@Test
	void testSuperficie() {
		assertEquals(p1.getSuperficie() + p2.getSuperficie(), reporte.superficieDeColor("Rojo"));
	}

}
