package ar.edu.info.unlp.oo1.ejercicioTeoriaPresupuestoExcursiones;

public class AlquilerDeEquipo implements Servicio {
	
	private int cantidadDeDias;
	private Equipo equipo;

	public double costoTotal() {
		return this.equipo.getCostoPorDia() * this.cantidadDeDias;
	}
}
