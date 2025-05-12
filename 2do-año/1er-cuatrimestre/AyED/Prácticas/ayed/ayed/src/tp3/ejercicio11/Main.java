package tp3.ejercicio11;

import tp3.ejercicio1.GeneralTree;

public class Main {

	public static void main(String[] args) {
		
		GeneralTree<Integer> raiz = new GeneralTree<>(2);

        // Nivel 1
        GeneralTree<Integer> n1 = new GeneralTree<>(1);
        GeneralTree<Integer> n2 = new GeneralTree<>(25);
        raiz.addChild(n1);
        raiz.addChild(n2);

        // Nivel 2
        GeneralTree<Integer> n3 = new GeneralTree<>(5);
        GeneralTree<Integer> n4 = new GeneralTree<>(4);
        GeneralTree<Integer> n5 = new GeneralTree<>(13);
        n1.addChild(n3);
        n1.addChild(n4);
        n2.addChild(n5);

        // Nivel 3
        GeneralTree<Integer> n6 = new GeneralTree<>(18);
        GeneralTree<Integer> n7 = new GeneralTree<>(7);
        GeneralTree<Integer> n8 = new GeneralTree<>(11);
        GeneralTree<Integer> n9 = new GeneralTree<>(3);
        n3.addChild(n6);
        n4.addChild(n7);
        n4.addChild(n8);
        n4.addChild(n9);

        // Nivel 4
        GeneralTree<Integer> n10 = new GeneralTree<>(83);
        GeneralTree<Integer> n11 = new GeneralTree<>(33);
        GeneralTree<Integer> n12 = new GeneralTree<>(12);
        GeneralTree<Integer> n13 = new GeneralTree<>(17);
        GeneralTree<Integer> n14 = new GeneralTree<>(9);
        n6.addChild(n10);
        n9.addChild(n11);
        n9.addChild(n12);
        n9.addChild(n13);
        n9.addChild(n14);
        
        System.out.println(ParcialArboles.resolver(raiz));
	}

}
