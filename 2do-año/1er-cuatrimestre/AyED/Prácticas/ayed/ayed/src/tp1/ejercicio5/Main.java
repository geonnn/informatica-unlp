package tp1.ejercicio5;

public class Main {
	
	public static int[] MetodoA(int[] arrInts) {
		int min = Integer.MAX_VALUE;
		int max = Integer.MIN_VALUE;
		int total = 0;
		for (int i : arrInts) {
			if (i < min)
				min = i;
			if (i > max)
				max = i;
			total += i;
		}
		int[] result = {max, min, (total/arrInts.length)};
		return result;
	}
	
	public static void MetodoB(int[] arrInts, Integer max, Integer min, Integer prom) {
		min = Integer.MAX_VALUE;
		max = Integer.MIN_VALUE;
		int total = 0;
		for (int i : arrInts) {
			if (i < min)
				min = i;
			if (i > max)
				max = Integer.valueOf(i);
			total += i;
		}
		prom = Integer.valueOf(total/arrInts.length);
	}

	public static void main(String[] args) {
		int[] arrEnteros = new int[10];
		
		for (int i = 0; i <= 9; i++) {
			arrEnteros[i] = (i+1)*10;
		}
		for (int i : arrEnteros) {
			System.out.println(i);
		}
		
		System.out.println();
		
		int[] resA = MetodoA(arrEnteros);
		System.out.println("Máx: " + resA[0]);
		System.out.println("Mín: " + resA[1]);
		System.out.println("Prom: " + resA[2]);
		
		Integer max = null, min = null, prom = null;
		MetodoB(arrEnteros, max, min, prom);
		System.out.println("Máx: " + max);
		System.out.println("Mín: " + min);
		System.out.println("Prom: " + prom);
	}

}
