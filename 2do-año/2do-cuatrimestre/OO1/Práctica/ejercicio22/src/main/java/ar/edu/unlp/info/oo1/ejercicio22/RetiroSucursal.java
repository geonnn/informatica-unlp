package ar.edu.unlp.info.oo1.ejercicio22;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class RetiroSucursal extends FormaEntrega {

	private int dni;
	
	@Override
	protected double tiempoEstimado(LocalDate fechaHoraCreacion) {
		return ChronoUnit.MINUTES.between(fechaHoraCreacion, this.getFechaHoraEstimada());
	}
}
