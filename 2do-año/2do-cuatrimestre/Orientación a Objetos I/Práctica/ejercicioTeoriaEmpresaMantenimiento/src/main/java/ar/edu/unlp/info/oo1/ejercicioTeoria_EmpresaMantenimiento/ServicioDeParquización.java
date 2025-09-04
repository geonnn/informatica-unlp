package ar.edu.unlp.info.oo1.ejercicioTeoria_EmpresaMantenimiento;

import java.util.ArrayList;
import java.util.List;

public class ServicioDeParquización extends Servicio {

	private List<Máquina> máquinas;
	
	public ServicioDeParquización(double precioPHora, double cantHoras, List<Máquina> máquinas) {
		super(precioPHora, cantHoras);
		this.máquinas = new ArrayList<Máquina>(máquinas);
	}
	
	public int getCantMaquinas() {
		return máquinas.size();
	}
	
	private double getCostoMantenimiento() {
		double total = 0;
		for (Máquina m : máquinas) {
			total += m.getCostoMantenimiento();
		}
		return total;
	}
	
	double aplicarCondiciones(double monto) {
		return monto + getCostoMantenimiento();
	}
}
