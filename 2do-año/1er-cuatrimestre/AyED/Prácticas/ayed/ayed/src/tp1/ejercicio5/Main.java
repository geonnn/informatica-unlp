package tp1.ejercicio5;

public class Main {

	public static void main(String[] args) {
		
		// Se crea el arreglo.
		int[] arrEnteros = new int[10];
		
		for (int i = 0; i <= 9; i++)
			arrEnteros[i] = (i+1)*10;
		
		for (int i : arrEnteros)
			System.out.println(i);
		
		System.out.println();
		
		// Llamadas a métodos para calcular los datos.
		int[] resA = Calculadora.MetodoA(arrEnteros);
		System.out.println("Máx: " + resA[0]);
		System.out.println("Mín: " + resA[1]);
		System.out.println("Prom: " + resA[2]);
		
		
		Datos datos = Calculadora.MetodoB(arrEnteros);
		System.out.println(datos.ToString());
		
		Calculadora.MetodoC(arrEnteros);
	}

}
