package ar.edu.unlp.info.oo1.ejercicio29;

public class PlanIndividual extends Plan {
	
	private int cantMins;
	
	public PlanIndividual(int cantMins) {
		this.setIpLimit(1);
		this.cantMins = cantMins;
	}
	
	@Override
	public double precioBase() {
		return 20 * this.cantMins;
	}

	@Override
	protected double calcularPenalizacion(int usedIps, int antiguedad) {
		if (usedIps > 1)
			return (usedIps-1) * 300;
		return 0;
	}

}
