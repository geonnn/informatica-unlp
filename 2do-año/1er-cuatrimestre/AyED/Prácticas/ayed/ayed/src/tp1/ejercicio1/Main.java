package tp1.ejercicio1;

public class Main {
	
	public static void main(String[] args) {
		int a = 10;
		int b = 20;
		
		ImprimirNumeros.ImprimirFor(a, b);
		System.out.println();
		ImprimirNumeros.ImprimirWhile(a, b);
		System.out.println();
		ImprimirNumeros.ImprimirRec(a, b);
	}

}
