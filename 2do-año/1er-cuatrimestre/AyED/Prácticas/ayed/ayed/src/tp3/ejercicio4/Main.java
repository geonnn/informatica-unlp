package tp3.ejercicio4;

import java.util.LinkedList;
import java.util.List;

import tp3.ejercicio1.GeneralTree;

public class Main {
	
	public static void main(String[] args) {
				
		List<GeneralTree<AreaEmpresa>> childrenJ = new LinkedList<GeneralTree<AreaEmpresa>>();
		childrenJ.add(new GeneralTree<AreaEmpresa>(new AreaEmpresa("A", 4)));
		childrenJ.add(new GeneralTree<AreaEmpresa>(new AreaEmpresa("B", 7)));
		childrenJ.add(new GeneralTree<AreaEmpresa>(new AreaEmpresa("C", 5)));
		GeneralTree<AreaEmpresa> aJ = new GeneralTree<AreaEmpresa>(new AreaEmpresa("J", 13), childrenJ);
			
		List<GeneralTree<AreaEmpresa>> childrenK = new LinkedList<GeneralTree<AreaEmpresa>>();
		childrenJ.add(new GeneralTree<AreaEmpresa>(new AreaEmpresa("D", 6)));
		childrenJ.add(new GeneralTree<AreaEmpresa>(new AreaEmpresa("E", 10)));
		childrenJ.add(new GeneralTree<AreaEmpresa>(new AreaEmpresa("F", 18)));
		GeneralTree<AreaEmpresa> aK = new GeneralTree<AreaEmpresa>(new AreaEmpresa("K", 25), childrenK);
		
		List<GeneralTree<AreaEmpresa>> childrenL = new LinkedList<GeneralTree<AreaEmpresa>>();
		childrenJ.add(new GeneralTree<AreaEmpresa>(new AreaEmpresa("G", 9)));
		childrenJ.add(new GeneralTree<AreaEmpresa>(new AreaEmpresa("H", 12)));
		childrenJ.add(new GeneralTree<AreaEmpresa>(new AreaEmpresa("I", 19)));
		GeneralTree<AreaEmpresa> aL = new GeneralTree<AreaEmpresa>(new AreaEmpresa("L", 10), childrenL);
		
		List<GeneralTree<AreaEmpresa>> childrenM = new LinkedList<GeneralTree<AreaEmpresa>>();
		childrenM.add(aJ); childrenM.add(aK); childrenM.add(aL);
		
		GeneralTree<AreaEmpresa> aM = new GeneralTree<AreaEmpresa>(new AreaEmpresa("M", 14), childrenM);
		
		AnalizadorArbol aAr = new AnalizadorArbol();
		
		System.out.print("máx promedio: ");
		System.out.print(aAr.devolverMaximoPromedio(aM));
	}
}
