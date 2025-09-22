package ar.edu.unlp.info.oo1.ejercicio6;

public class Consumo {
	
	private double activa;
	private double reactiva;

	public Consumo(double activa, double reactiva) {
		this.activa = activa;
		this.reactiva = reactiva;
	}
	
	public double getEnergiaActiva() {
		return activa;
	}
	
	public double getEnergiaReactiva() {
		return reactiva;
	}
	
	// P: activa
	// Q: reactiva
	// S: aparente
	// S^2 = P^2 + Q^2
	// Factor de potencia = P/S
	public double calcularFPE() {
		double aparente = Math.sqrt((activa*activa)+(reactiva*reactiva));
		return activa / aparente;
	}
}
