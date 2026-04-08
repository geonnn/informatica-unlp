package ar.edu.unlp.info.oo2.repaso_ejercicio02;

import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		
		System.out.println("---------- PIEDRA PAPEL O TIJERA ----------");
		System.out.println();
		System.out.println("Nombre del jugador 1: ");
		String jug1 = scanner.nextLine();
		System.out.println("Bienvenido " + jug1 + "!");
		System.out.println();
		
		System.out.println("Nombre del jugador 2: ");
		String jug2 = scanner.nextLine();
		System.out.println("Bienvenido " + jug2 + "!");
		System.out.println();
		System.out.println("---------- COMIENZA EL JUEGO ----------");
		System.out.println();
		
		Juego juego = new Juego(new Jugador(jug1), new Jugador(jug2));
		juego.ejecutar();
		
		scanner.close();
	}
	
	
}
