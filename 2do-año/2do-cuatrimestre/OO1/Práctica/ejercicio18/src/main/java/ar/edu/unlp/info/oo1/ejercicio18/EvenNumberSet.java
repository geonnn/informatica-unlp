package ar.edu.unlp.info.oo1.ejercicio18;

import java.util.HashSet;

public class EvenNumberSet<Integer> extends HashSet<Integer>{
	
	@Override
	public boolean add(Integer n) {
		if (this.isEven(n))
			return super.add(n);
		return false;
	}
	
	private boolean isEven(Integer n) {
		return (int)n % 2 == 0;
	}
}
