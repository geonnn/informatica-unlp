package ar.edu.info.unlp.oo1.ejercicioTeoriaPresupuestoExcursiones;

import java.util.List;

public class Excursion implements Servicio {
	
	private double costoDeTraslado;
	private double costoDelGuia;
	private double valorDelSeguro;
	private List<Lugar> lugares;
	
	public double costoTotal() {
		return this.costoDeTraslado + this.costoDelGuia + this.valorDelSeguro;
	}
}
