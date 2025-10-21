package ar.edu.unlp.info.oo1.ejercicioTeoria_EmpresaMantenimiento;

public class Máquina {
	
	private String descripción;
	private double costoMantenimiento;
	
	public Máquina(String descripción, double costoMantenimiento) {
		this.descripción = descripción;
		this.costoMantenimiento = costoMantenimiento;
	}

	public double getCostoMantenimiento() {
		return costoMantenimiento;
	}
}
