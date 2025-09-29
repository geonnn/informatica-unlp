package ar.edu.unlp.info.oo1.ejercicio14;

public abstract class Pieza {
	
	private String material;
	private String color;
	
	public Pieza(String material, String color) {
		this.material = material;
		this.color = color;
	}
	
	public String getMaterial() {
		return this.material;
	}
	
	public String getColor() {
		return this.color;
	}
	
	abstract double getVolumen();
	abstract double getSuperficie();

}
