package ar.edu.unlp.info.oo1.ejercicio5;

public class Cuadrado extends Figura2D{
	
	private double lado;

	void setLado(double lado) {
		this.lado = lado;
	}
	
	double getLado() {
		return lado;
	}
	
	double getPerimetro() {
		return lado * 4;
	}
	
	double getArea() {
		return lado * lado;
	}
}
