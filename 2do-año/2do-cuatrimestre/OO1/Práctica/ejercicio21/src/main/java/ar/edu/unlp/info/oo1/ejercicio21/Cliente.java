package ar.edu.unlp.info.oo1.ejercicio21;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public abstract class Cliente {

	private String nombre;
	private String direccion;
	private List<Envio> envios;
	
	protected Cliente(String nombre, String direccion) {
		this.nombre = nombre;
		this.direccion = direccion;
		this.envios = new ArrayList<Envio>();
	}
	
	public void addEnvio(Envio envio) {
		this.envios.add(envio);
	}
	
	public double montoAPagarPeriodo(LocalDate from, LocalDate to) {
		return this.envios.stream()
				.filter(e -> dateIsIncluded(from, to, e.getFechaDespacho()))
				.mapToDouble(e -> e.monto()).sum();
//		double montoTotal = 0;
//		for (Envio e : envios) {
//			if (dateIsIncluded(from, to, e.getFechaDespacho())) {
//				montoTotal += e.monto();
//			}
//		}
//		return montoTotal;
	}
	
	private boolean dateIsIncluded(LocalDate from, LocalDate to, LocalDate date) {
		return (date.isEqual(from) || date.isAfter(from)) &&
				(date.isEqual(to) || date.isBefore(to));
	}
}
