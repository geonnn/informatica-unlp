package tp3.ejercicio10;

import tp3.ejercicio1.GeneralTree;

public class Main {

	public static void main(String[] args) {
		
		GeneralTree<Integer> raiz = new GeneralTree<>(1);

        // Nivel 1
        GeneralTree<Integer> n1 = new GeneralTree<>(0);
        GeneralTree<Integer> n2 = new GeneralTree<>(1);
        GeneralTree<Integer> n3 = new GeneralTree<>(1);
        raiz.addChild(n1);
        raiz.addChild(n2);
        raiz.addChild(n3);

        // Nivel 2
        GeneralTree<Integer> n4 = new GeneralTree<>(1);  // hijo de 0
        GeneralTree<Integer> n5 = new GeneralTree<>(1);  // hijo de 0
        GeneralTree<Integer> n6 = new GeneralTree<>(1);  // hijo de 1 (central)
        GeneralTree<Integer> n7 = new GeneralTree<>(0);  // hijo de 1 (central)
        GeneralTree<Integer> n8 = new GeneralTree<>(0);  // hijo de 1 (derecha)
        n1.addChild(n4);
        n1.addChild(n5);
        n2.addChild(n6);
        n2.addChild(n7);
        n3.addChild(n8);

        // Nivel 3
        GeneralTree<Integer> n9 = new GeneralTree<>(1);  // hijo de n4
        GeneralTree<Integer> n10 = new GeneralTree<>(1);  // hijo de n4
        GeneralTree<Integer> n11 = new GeneralTree<>(1); // hijo de n4
        GeneralTree<Integer> n12 = new GeneralTree<>(0); // hijo de n7
        GeneralTree<Integer> n13 = new GeneralTree<>(0); // hijo de n8
        n4.addChild(n9);
        n4.addChild(n10);
        n4.addChild(n11);
        n7.addChild(n12);
        n8.addChild(n13);

        // Nivel 4
        GeneralTree<Integer> n14 = new GeneralTree<>(1);  // hijo de n12
        GeneralTree<Integer> n15 = new GeneralTree<>(0);  // hijo de n13
        GeneralTree<Integer> n16 = new GeneralTree<>(0);  // hijo de n13
        n12.addChild(n14);
        n13.addChild(n15);
        n13.addChild(n16);
        
        System.out.println(ParcialArboles.resolver(raiz));
	}

}
