package ar.edu.unlp.info.oo1.ejercicioTeoria_EmpresaMantenimiento;

public abstract class Servicio {
	
	private double precioPHora;
	private double cantHoras;

	Servicio(double precioPHora, double cantHoras) {
		this.precioPHora = precioPHora;
		this.cantHoras = cantHoras;
	}
	
	public double getMonto() {
		double montoBase = precioPHora * cantHoras;
		return aplicarCondiciones(montoBase);
	}
	
	abstract double aplicarCondiciones(double montoBase);
}
