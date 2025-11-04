package ar.edu.unlp.info.oo1.ejercicio22;

import java.time.LocalDate;

public abstract class Pedido {

	private String emailCliente;
	private LocalDate fechaHoraCreacion;
	private FormaEntrega formaEntrega;
	
	protected LocalDate getFechaHoraCreacion() {
		return this.fechaHoraCreacion;
	}
	
	public double tiempoEntregaEstimado() {
		return this.formaEntrega.tiempoEstimado(this.fechaHoraCreacion);
	}
	
	protected abstract double costo();
}
