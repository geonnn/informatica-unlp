package tp1.ejercicio5;

public class Calculadora {

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
	
	public static Datos MetodoB(int[] arrInts) {
		Datos datos = new Datos();
		int[] results = MetodoA(arrInts);
		datos.setMax(results[0]);
		datos.setMin(results[1]);
		datos.setProm(results[2]);
		return datos;
	}
	
	public static void MetodoC(int[] arrInts) {
		Datos datos = MetodoB(arrInts);
		System.out.println(datos.ToString());
	}
}
