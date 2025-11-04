package ar.edu.unlp.info.oo1.ejercicio22;

import java.time.LocalDate;

public abstract class FormaEntrega {

	private LocalDate fechaHoraEstimada;

	protected LocalDate getFechaHoraEstimada() {
		return this.fechaHoraEstimada;
	}
	
	protected abstract double tiempoEstimado(LocalDate fechaHoraCreacion);
}
