package ar.edu.unlp.info.oo1.ejercicio29;

public class PlanGrupal extends Plan {
	
	public PlanGrupal(int ipLimit) {
//		if (ipLimit < 2)
//			throw exception ... 
		this.setIpLimit(ipLimit);
	}
	
	@Override
	public double precioBase() {
		return 800 * this.getIpLimit();
	}

	@Override
	protected double calcularPenalizacion(int usedIps, int antiguedad) {
		if (antiguedad > 10)
			return 0;
		
		double ipLimit = this.getIpLimit();
		if (usedIps > ipLimit)
			return (usedIps - ipLimit) * 500;
		
		return 0;
	}

}
