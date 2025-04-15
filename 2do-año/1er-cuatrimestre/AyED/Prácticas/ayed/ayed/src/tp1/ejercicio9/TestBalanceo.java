package tp1.ejercicio9;

import java.util.Stack;

public class TestBalanceo {
	
	public static boolean estaBalanceado(String s) {
		Stack<Character> pila = new Stack<>();
		
		for (char c : s.toCharArray()) {
			if (c == '(' || c == '[' || c == '{')
				pila.push(c);
			else if (c == ')' || c == ']' || c == '}') {
				if (pila.isEmpty()) return false;
				char top = pila.pop();
				if (!coinciden(top, c)) return false;
			}
		}
		return pila.isEmpty();
	}
	
	private static boolean coinciden(char apertura, char cierre) {
		return  (apertura == '(' && cierre == ')') ||
				(apertura == '[' && cierre == ']') ||
				(apertura == '{' && cierre == '}');
				
	}
}	