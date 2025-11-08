package ar.edu.unlp.info.oo1.ejercicio29;

public abstract class Plan {
	
	private int ipLimit;

	protected void setIpLimit(int ipLimit) {
		this.ipLimit = ipLimit;
	}
	
	protected int getIpLimit() {
		return this.ipLimit;
	}
	
	protected abstract double calcularPenalizacion(int usedIps, int antiguedad);
	public abstract double precioBase();
}
