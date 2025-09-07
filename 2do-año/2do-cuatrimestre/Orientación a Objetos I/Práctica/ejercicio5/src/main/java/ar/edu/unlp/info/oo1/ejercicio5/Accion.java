package ar.edu.unlp.info.oo1.ejercicio5;

public class Accion extends Inversion {
	
	private String nombre;
	private int cantidad;
	private double valorUnitario;
	
	public Accion(String nombre, int cantidad, double valorUnitario) {
		this.nombre = nombre;
		this.cantidad = cantidad;
		this.valorUnitario = valorUnitario;
	}

	@Override
	public double getValorActual() {
		return cantidad * valorUnitario;
	}
}
