package ar.edu.unlp.info.oo1.ejercicio7;

public class Circulo extends Figura2D {
	
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
	
	double getPerimetro() {
		return Math.PI * getDiametro();
	}
	
	double getArea() {
		return Math.PI * (radio * radio);
	}
}
