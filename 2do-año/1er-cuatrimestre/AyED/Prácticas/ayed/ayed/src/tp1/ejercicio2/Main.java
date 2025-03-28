package tp1.ejercicio2;
import java.util.Scanner;

public class Main {
	
	public static void main(String[] args) {
		
		Scanner s = new Scanner(System.in);
		while (s.nextInt() != 0) {
			int[] arr1 = Arreglo.MultiplosN(s.nextInt());
			for (int i : arr1) {
				System.out.println(i);
			}
		}
	}
}
