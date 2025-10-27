package ar.edu.unlp.info.oo1.ejercicio19;

import ar.edu.unlp.info.oo1.ejercicio17.DateLapse;

public class Reserva {
	
	private Inmueble inmueble;
	private DateLapse dl;
	
	public Reserva(Inmueble inmueble, DateLapse dl) {
		this.inmueble = inmueble;
		this.dl = dl;
		this.inmueble.addReserva(this);
	}
	
	public DateLapse getDateLapse() {
		return this.dl;
	}
	
	public double getPrecio() {
		return this.inmueble.getPrecioPNoche() * dl.sizeInDays();
	}
}
