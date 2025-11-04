package ar.edu.unlp.info.oo1.ejercicio22;

import java.time.LocalDate;

public class Envío extends FormaEntrega {
	
	private String direccion;

	@Override
	protected double tiempoEstimado(LocalDate fechaHoraCreacion) {
		// Envío por delivery: La empresa lo calcula en tiempo real utilizando GPS, el estado del tráfico y fórmulas de distancia.
		return 0;
	}
}
