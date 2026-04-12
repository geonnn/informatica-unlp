package ar.edu.unlp.info.oo2.repaso_ejercicio02;

public class Juego {

	private Jugador jugador1;
	private Jugador jugador2;
	private int rondasGanadasJugador1 = 0;
	private int rondasGanadasJugador2 = 0;
	private int victoriasObjetivo = 2;
	
	public Juego(Jugador jugador1, Jugador jugador2) {
		this.jugador1 = jugador1;
		this.jugador2 = jugador2;
	}
	
	public void ejecutar() {
		do {
			System.out.println();
			System.out.println(jugador1.getNombre() + ", seleccione una opción: ");
			Opcion op1 = Menu.printMenu();
			System.out.println();
			System.out.println(jugador2.getNombre() + ", seleccione una opción: ");
			Opcion op2 = Menu.printMenu();

			ronda(op1, op2);
		} while (!fin());
		
		System.out.println("El ganador es " + ganador().getNombre() + "!");
	}
	
	public Jugador ganador() {
		if (rondasGanadasJugador1 == victoriasObjetivo)
			return jugador1;
		else
			return jugador2;
	}
	
	private boolean fin() {
		return (rondasGanadasJugador1 == victoriasObjetivo) || (rondasGanadasJugador2 == victoriasObjetivo);
	}
	
	private void ronda(Opcion op1, Opcion op2) {
		System.out.println();
		// System.out.println(op1 + "vs." + op2);
		
		switch (op1.comparar(op2)) {
		case 0:
			System.out.println("Gana la ronda " + jugador2.getNombre() + "!");
			rondasGanadasJugador2++;
			break;
		case 1:
			System.out.println("Gana la ronda " + jugador1.getNombre() + "!");
			rondasGanadasJugador1++;
			break;
		default:
			System.out.println("Empate!");
			break;
		}
	}
}
