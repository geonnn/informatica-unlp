package ar.edu.unlp.info.oo1.ejercicio7;

public class Circulo implements Figura2D {
	
	private double radio;

	void setRadio(double radio) {
		this.radio = radio;
	}
	
	void setDiametro(double diametro) {
		radio = diametro / 2;
	}
	
	double getRadio() {
		return radio;
	}
	
	double getDiametro() {
		return radio * 2;
	}
	
	public double getPerimetro() {
		return Math.PI * getDiametro();
	}
	
	public double getArea() {
		return Math.PI * (radio * radio);
	}
}
