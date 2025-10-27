package ar.edu.unlp.info.oo1.ejercicio19;

import java.util.ArrayList;
import java.util.List;

import ar.edu.unlp.info.oo1.ejercicio17.DateLapse;

public class Usuario {
	
	private String nombre;
	private String direccion;
	private int dni;
	private List<Inmueble> propiedades; // como dueño
	private List<Reserva> reservas; // como huésped
	
	public Usuario(String nombre, String direccion, int dni) {
		this.nombre = nombre;
		this.direccion = direccion;
		this.dni = dni;
		this.propiedades = new ArrayList<>();
		this.reservas = new ArrayList<>();
	}
	
	public boolean addBooking(Inmueble i, DateLapse dl) {
		if (i.isAvailable(dl)) {
			this.book(i, dl);
			return true;
		}
		return false;
	}
	
	private void book(Inmueble i, DateLapse dl) {
		this.reservas.add(new Reserva(i, dl));
	}
	
	public boolean cancelBooking() {
		
	}
}
