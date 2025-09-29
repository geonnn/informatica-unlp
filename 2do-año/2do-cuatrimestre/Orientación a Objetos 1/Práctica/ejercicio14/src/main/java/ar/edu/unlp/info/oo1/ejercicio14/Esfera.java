package ar.edu.unlp.info.oo1.ejercicio14;

public class Esfera extends Pieza {
	
	private double radio;

	public Esfera(String material, String color, double radio) {
		super(material, color);
		this.radio = radio;
	}

	@Override
	double getVolumen() {
		return 4/3 * Math.PI * Math.pow(this.radio, 3);
	}

	@Override
	double getSuperficie() {
		return 4 * Math.PI * Math.pow(this.radio, 2);
	}

}
