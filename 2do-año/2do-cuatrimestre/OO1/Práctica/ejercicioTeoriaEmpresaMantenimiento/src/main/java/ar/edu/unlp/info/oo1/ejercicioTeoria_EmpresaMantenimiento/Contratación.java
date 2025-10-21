package ar.edu.unlp.info.oo1.ejercicioTeoria_EmpresaMantenimiento;

import java.time.LocalDate;

public abstract class Contratación {
	
	private LocalDate fecha;
	private Servicio servicio;
	
	Contratación(LocalDate fecha, Servicio servicio) {
		this.fecha = fecha;
		this.servicio = servicio;
	}

	public double getMonto() {
		double montoBase = servicio.getMonto();
		return aplicarCondiciones(montoBase);
	}
	
	abstract double aplicarCondiciones(double montoBase);
	
	LocalDate getFecha() {
		return fecha;
	}
}
