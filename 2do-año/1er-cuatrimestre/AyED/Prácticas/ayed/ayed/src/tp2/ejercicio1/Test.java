package tp2.ejercicio1;

import java.util.LinkedList;
import tp2.ejercicio3.ContadorArbol;

public class Test {
	
	public static void main(String[] args) {
		
		BinaryTree<Integer> arbol = new BinaryTree<Integer>(1);
		arbol.addLeftChild(new BinaryTree<Integer>(2));
		arbol.addRightChild(new BinaryTree<Integer>(3));
		arbol.getLeftChild().addLeftChild(new BinaryTree<Integer>(4));
		arbol.getLeftChild().addRightChild(new BinaryTree<Integer>(5));
		arbol.getRightChild().addLeftChild(new BinaryTree<Integer>(6));
		
		System.out.println("hojas: " + arbol.contarHojas());
		
		System.out.println("-------------------");
		arbol.imprimirArbol();
		System.out.println("-------------------");
//		arbol.imprimirArbol(arbol.espejo());		
//		System.out.println("-------------------");
//		System.out.println("por niveles: ");
//		arbol.entreNiveles(1, 2);
		
		ContadorArbol contArbol = new ContadorArbol(arbol);
		LinkedList<Integer> list = new LinkedList<Integer>(contArbol.numerosParesInOrden());
		
		for (Integer integer : list) {
			System.out.println(integer);
		}
	}

}
