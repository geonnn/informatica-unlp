package tp1.ejercicio1;

public class ImprimirNumeros {
	
	public static void ImprimirFor(int a, int b) {
		for(int i = a; i <= b; i++)
			System.out.println(i);
	}
	
	public static void ImprimirWhile(int a, int b) {
		while (a <= b)
			System.out.println(a++);
				
	}

	public static void ImprimirRec(int a, int b) {
		System.out.println(a++);
		if (a <= b)
			ImprimirRec(a, b);
	}


}
