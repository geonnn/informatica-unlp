package ar.edu.unlp.info.oo1.ejercicioTeoria_EmpresaMantenimiento;

import java.util.List;

public class Cliente {
	
	private String nombre;
	private String apellido;
	private String direccion;
	private List<Contratación> contrataciones;
	
	public Cliente(String nombre, String apellido, String direccion, List<Contratación> contrataciones) {
		this.nombre = nombre;
		this.apellido = apellido;
		this.direccion = direccion;
		this.contrataciones = contrataciones;
	}
	
	public double getMontoAdeudado() {
		double total = 0;
		for (Contratación c : contrataciones) {
			total += c.getMonto();
		}
		return total;
	}
	
	public int servsMayorA(double monto) {
		int count = 0;
		for (Contratación c : contrataciones) {
			if (c.getMonto() > monto)
				count++;
		}
		return count;
	}
}
