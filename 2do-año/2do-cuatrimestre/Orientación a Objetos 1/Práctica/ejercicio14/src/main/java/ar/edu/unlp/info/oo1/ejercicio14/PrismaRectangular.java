package ar.edu.unlp.info.oo1.ejercicio14;

public class PrismaRectangular extends Pieza {
	
	private double altura, ladoMenor, ladoMayor;
	
	public PrismaRectangular(String material, String color, double altura, double ladoMenor, double ladoMayor) {
		super(material, color);
		this.altura = altura;
		this.ladoMenor = ladoMenor;
		this.ladoMayor = ladoMayor;
	}

	@Override
	double getVolumen() {
		return this.ladoMenor * this.ladoMayor * this.altura;
	}

	@Override
	double getSuperficie() {
		return 2 * (this.ladoMayor * this.ladoMenor + this.ladoMayor * this.altura + this.ladoMenor * this.altura); 
	}

	
}
