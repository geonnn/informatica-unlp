package ar.edu.unlp.info.oo2.repaso_ejercicio02;

public interface Opcion {

	// 0: pierde
	// 1: gana
	// 2: empata
	
	// compararConX se responde desde la perspectiva de X.
	// ejemplo en clase Piedra.
	
	int comparar(Opcion opcion);
	int compararConPiedra();
	int compararConPapel();
	int compararConTijera();
}
