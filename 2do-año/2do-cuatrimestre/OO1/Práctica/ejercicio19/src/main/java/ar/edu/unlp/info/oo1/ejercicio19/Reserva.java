package ar.edu.unlp.info.oo1.ejercicio19;

import java.time.LocalDate;

import ar.edu.unlp.info.oo1.ejercicio17.DateLapse;

public class Reserva {
	
	private Inmueble inmueble;
	private DateLapse dl;
	private Usuario usuario;
	
	public Reserva(Usuario usuario, Inmueble inmueble, DateLapse dl) {
		this.inmueble = inmueble;
		this.dl = dl;
		this.usuario = usuario;
	}
	
	public DateLapse getDateLapse() {
		return this.dl;
	}
	
	public double getPrecio() {
		return this.inmueble.getPrecioPNoche() * dl.sizeInDays();
	}
	
	public int getCoincidencias(DateLapse dl) {
		return this.dl.coincidencias(dl);
	}
	
	public boolean includesDate(LocalDate ld) {
		return this.dl.includesDate(ld);
	}
}
