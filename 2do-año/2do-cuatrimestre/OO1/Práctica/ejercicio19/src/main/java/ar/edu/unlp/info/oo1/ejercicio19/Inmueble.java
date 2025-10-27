package ar.edu.unlp.info.oo1.ejercicio19;

import java.util.Iterator;
import java.util.List;

import ar.edu.unlp.info.oo1.ejercicio17.DateLapse;

public class Inmueble {

	private String nombre;
	private String direccion;
	private double precioPNoche;
	private List<Reserva> reservas;
	
	public boolean isAvailable(DateLapse dl) {
		Iterator<Reserva> it = this.reservas.iterator();
		boolean overlaps = false;
		while (it.hasNext() && !overlaps) {
			Reserva r = it.next();
			overlaps = dl.overlaps(r.getDateLapse());
		}
		return overlaps;
	}
	
	public void addReserva(Reserva r) {
		this.reservas.add(r);
	}
	
	public double getPrecioPNoche() {
		return this.precioPNoche;
	}
}
