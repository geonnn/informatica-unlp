package ar.edu.unlp.info.oo1.ejercicioTeoria_EmpresaMantenimiento;

public class ServicioDeLimpieza extends Servicio {

	private double tarifaMinima;
	
	public ServicioDeLimpieza(double precioPHora, double cantHoras, double tarifaMinima) {
		super(precioPHora, cantHoras);
		this.tarifaMinima = tarifaMinima;
	}
	
	double aplicarCondiciones(double monto) {
		return (monto > tarifaMinima) ? monto : tarifaMinima;
	}
	
}
