package ar.edu.unlp.info.oo1.ejercicio19;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import ar.edu.unlp.info.oo1.ejercicio17.DateLapse;

public class Inmueble {

	private String nombre;
	private String direccion;
	private double precioPNoche;
	private List<Reserva> reservas;
	
	public Inmueble(String nombre, String direccion, double precioPNoche) {
		this.nombre = nombre;
		this.direccion = direccion;
		this.precioPNoche = precioPNoche;
		this.reservas = new ArrayList<Reserva>();
	}

	public boolean isAvailable(DateLapse dl) {
		Iterator<Reserva> it = this.reservas.iterator();
		boolean overlaps = false;
		while (it.hasNext() && !overlaps) {
			Reserva r = it.next();
			overlaps = dl.overlaps(r.getDateLapse());
		}
		return overlaps;
	}
	
	public boolean addReserva(Usuario u, DateLapse dl) {
		if (this.isAvailable(dl)) {
			this.reservas.add(new Reserva(u, this, dl));
			return true;
		}
		return false;
	}
	
	public boolean removeReserva(Reserva r) {
		if (!r.includesDate(LocalDate.now())) {
			this.reservas.remove(r);
			return true;
		}
		return false;
	}
	
	public double getPrecioPNoche() {
		return this.precioPNoche;
	}
	
	public double getIngresos(DateLapse dl) {
		return this.reservas.stream().
				mapToInt(r -> r.getCoincidencias(dl))
				.sum() * this.precioPNoche * 0.75;
	}
}
