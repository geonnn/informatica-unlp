package ar.edu.unlp.info.oo2.repaso_ejercicio02;

public class Piedra implements Opcion {

	@Override
	public int comparar(Opcion opcion) {
		return (opcion.compararConPiedra());
	}

	@Override
	public int compararConPiedra() {
		return 2;
	}

	// Si papel juega contra mí (piedra) ¿cómo le va a papel?
	@Override
	public int compararConPapel() {
		return 1; // papel gana.
	}

	@Override
	public int compararConTijera() {
		return 0;
	}

}
