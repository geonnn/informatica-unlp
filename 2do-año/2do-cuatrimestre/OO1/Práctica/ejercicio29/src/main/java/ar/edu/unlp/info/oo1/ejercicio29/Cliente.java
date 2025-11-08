package ar.edu.unlp.info.oo1.ejercicio29;

import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import ar.edu.unlp.info.oo1.ejercicio17.DateLapse;

public class Cliente {

	private String nombre;
	private LocalDate fechaAlta;
	private Plan plan;
	private List<Actividad> actividades;
	
	public Cliente(String nombre, Plan plan) {
		this.nombre = nombre;
		this.fechaAlta = LocalDate.now();
		this.plan = plan;
		this.actividades = new ArrayList<>();
	}
	
	public void cambiarPlan(Plan p) {
		this.plan = p;
	}
	
	public void addActividad(Actividad a) {
		this.actividades.add(a);
	}
	
	public double montoTotal(LocalDate ini, LocalDate fin) {
		DateLapse dl = new DateLapse(ini, fin);
		return this.plan.precioBase()
				+ this.montoActividad(dl)
				+ this.montoPenalizacion(dl);
	}
	
	public double montoActividad(DateLapse dl) {
		return this.actividades.stream()
				.filter(a -> dl.includesDate(a.getFechaIni()))
				.mapToDouble(a -> a.monto())
				.sum();
	}
	
	private int antiguedad() {
		return Period.between(this.fechaAlta, LocalDate.now()).getYears();
	}
	
	public double montoPenalizacion(DateLapse dl) {
		Set<String> ips = this.actividades.stream()
						  .filter(a -> dl.includesDate(a.getFechaIni()))
						  .map(a -> a.getIp())
						  .collect(Collectors.toSet());
		
		int used = ips.size();
		return this.plan.calcularPenalizacion(used, this.antiguedad());
	}
}
