package ar.edu.unlp.info.oo1.ejercicio5;

public class Cuerpo3D {

	private double altura;
	private Figura2D caraBasal;
	
	void setAltura(double altura) {
		this.altura = altura;
	}
	
	void setCaraBasal(Figura2D caraBasal) {
		this.caraBasal = caraBasal;
	}
	
	double getAltura() {
		return altura;
	}
	
	double getVolumen() {
		return caraBasal.getArea() * altura;
	}
	
	double getSuperficieExterior() {
		return (2 * caraBasal.getArea()) + (caraBasal.getPerimetro() * altura);
	}
}
