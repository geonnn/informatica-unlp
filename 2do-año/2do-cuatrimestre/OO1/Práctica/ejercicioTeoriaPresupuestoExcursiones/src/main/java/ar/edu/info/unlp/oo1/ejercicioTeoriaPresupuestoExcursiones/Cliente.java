package ar.edu.info.unlp.oo1.ejercicioTeoriaPresupuestoExcursiones;

import java.util.List;

public class Cliente {
	
	private List<Presupuesto> historial;

	public double costoFinal(Presupuesto p) {
		double res = p.costo();
		if (this.cumpleDescuento())
			res *= 0.9;
		return res;
	}
	
	private boolean cumpleDescuento() {
		return (this.historial.size() > 5) && (this.costoPresupuestos() > 1_000_000);
	}
	
	private double costoPresupuestos() {
		return this.historial.stream()
				.mapToDouble(p -> p.costo())
				.sum();
	}
}
