package ar.edu.unlp.info.oo1.ejercicio21;

import java.time.LocalDate;

public abstract class Envio {
		
	private LocalDate fechaDespacho;
	private double peso;
	private String origen;
	private String destino;

	protected Envio(LocalDate fechaDespacho, double pesoEnGramos, String origen, String destino) {
		this.origen = origen;
		this.destino = destino;
		this.fechaDespacho = fechaDespacho;
		this.peso = pesoEnGramos;
	}
	
	protected LocalDate getFechaDespacho() {
		return this.fechaDespacho;
	}
	
	protected double getPesoGr() {
		return this.peso;
	}
	
	public abstract double monto();
}
