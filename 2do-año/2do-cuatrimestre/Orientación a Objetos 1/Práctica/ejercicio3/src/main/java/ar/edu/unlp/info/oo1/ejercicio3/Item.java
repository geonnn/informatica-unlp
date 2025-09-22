package ar.edu.unlp.info.oo1.ejercicio3;

public class Item {
	
	private String detalle;
	private int cantidad;
	private double costoUnitario;

	public Item(String detalle, int cantidad, double costoUnitario) {
		this.detalle = detalle;
		this.cantidad = cantidad;
		this.costoUnitario = costoUnitario;
	}

	double getCostoUnitario() {
		return costoUnitario;
	}
	
	public String getDetalle() {
		return detalle;
	}

	double costo() {
		return costoUnitario * cantidad;
	}
}
