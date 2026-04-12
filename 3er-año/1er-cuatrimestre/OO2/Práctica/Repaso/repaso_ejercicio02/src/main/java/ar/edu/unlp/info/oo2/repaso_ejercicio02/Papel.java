package ar.edu.unlp.info.oo2.repaso_ejercicio02;

public class Papel implements Opcion {

	@Override
	public int comparar(Opcion opcion) {
		return opcion.compararConPapel();
	}

	@Override
	public int compararConPiedra() {
		return 0;
	}

	@Override
	public int compararConPapel() {
		return 2;
	}

	@Override
	public int compararConTijera() {
		return 1;
	}

}
