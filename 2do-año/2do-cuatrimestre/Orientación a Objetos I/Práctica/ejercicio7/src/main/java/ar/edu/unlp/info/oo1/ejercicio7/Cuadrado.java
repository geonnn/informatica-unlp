package ar.edu.unlp.info.oo1.ejercicio7;

public class Cuadrado implements Figura2D{
	
	private double lado;

	void setLado(double lado) {
		this.lado = lado;
	}
	
	double getLado() {
		return lado;
	}
	
	public double getPerimetro() {
		return lado * 4;
	}
	
	public double getArea() {
		return lado * lado;
	}
}
