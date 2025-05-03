package tp3.ejercicio2;
import tp3.ejercicio1.GeneralTree;
import java.util.List;
import java.util.LinkedList;

public class Main {

	public static void main(String[] args) {
		
		GeneralTree<Integer> a1 = new GeneralTree<Integer>(1);
		
		List<GeneralTree<Integer>> children2 = new LinkedList<GeneralTree<Integer>>();
		children2.add(new GeneralTree<Integer>(21));
		children2.add(new GeneralTree<Integer>(22));
		children2.add(new GeneralTree<Integer>(23));
		GeneralTree<Integer> a2 = new GeneralTree<Integer>(2, children2); 
	
		List<GeneralTree<Integer>> children3 = new LinkedList<GeneralTree<Integer>>();
		children3.add(new GeneralTree<Integer>(31));
		children3.add(new GeneralTree<Integer>(32));
		GeneralTree<Integer> a3 = new GeneralTree<Integer>(3, children3);
		
		List<GeneralTree<Integer>> children = new LinkedList<GeneralTree<Integer>>();
		children.add(a1); children.add(a2); children.add(a3);
		
		GeneralTree<Integer> ag = new GeneralTree<Integer>(0, children);
		
		RecorridosAG rAg = new RecorridosAG();
		
		
		for (Integer n : rAg.numerosImparesMayoresQuePorNiveles(ag, 0)) {
			System.out.println(n);
		}
	}

}
