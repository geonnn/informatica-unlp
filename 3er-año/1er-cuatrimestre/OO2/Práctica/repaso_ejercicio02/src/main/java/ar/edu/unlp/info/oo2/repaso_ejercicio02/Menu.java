package ar.edu.unlp.info.oo2.repaso_ejercicio02;

import java.util.Scanner;

public class Menu {

	public static Opcion printMenu() {
		
		boolean ok = false;
		String input;
		int opc = 0;
		Opcion result = null;
		Scanner scanner = new Scanner(System.in);
		
		do {
			do {
				System.out.println();
				System.out.println("1. Piedra");
				System.out.println("2. Papel");
				System.out.println("3. Tijera");
				input = scanner.nextLine();
				
				try {
					opc = Integer.parseInt(input);
					ok = true;
				} catch (Exception e) {
					break;
				}
			} while (!ok);
			
			switch (opc) {
			case 1:
				result = new Piedra();
				break;
			case 2:
				result = new Papel();
				break;
			case 3:
				result = new Tijera();
				break;
			default:
				System.out.println("Ingrese una opción válida.");
				ok = false;
			}
		} while (!ok);
		
		return result;
	}
}
