package ar.edu.unlp.info.oo2.repaso_ejercicio02;

public class Tijera implements Opcion {

	@Override
	public int comparar(Opcion opcion) {
		return opcion.compararConTijera();
	}

	@Override
	public int compararConPiedra() {
		return 1;
	}

	@Override
	public int compararConPapel() {
		return 0;
	}

	@Override
	public int compararConTijera() {
		return 2;
	}

}
