package ar.edu.info.unlp.oo1.ejercicioTeoriaPresupuestoExcursiones;

import java.util.List;

public class Presupuesto {
	
	private List<Servicio> servicios;

	public double costo() {
		return this.servicios.stream()
				.mapToDouble(s -> s.costoTotal())
				.sum();
	}
}
