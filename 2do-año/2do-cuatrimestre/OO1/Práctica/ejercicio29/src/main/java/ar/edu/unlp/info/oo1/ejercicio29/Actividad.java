package ar.edu.unlp.info.oo1.ejercicio29;

import java.time.LocalDate;

public abstract class Actividad {
	
	private LocalDate fIni;
	private String ip;
	
	protected Actividad(LocalDate fIni, String ip) {
		this.fIni = fIni;
		this.ip = ip;
	}
	
	protected String getIp() {
		return this.ip;
	}
		
	protected LocalDate getFechaIni() {
		return this.fIni;
	}
	
	protected abstract double monto();

}
