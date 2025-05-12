package tp3.ejercicio9;

import java.util.*;
import tp3.ejercicio1.GeneralTree;

public class Main {

    public static void main(String[] args) {
        // Nivel 4
        GeneralTree<Integer> n35hoja = new GeneralTree<>(35);
        GeneralTree<Integer> n35hoja2 = new GeneralTree<>(35);
        GeneralTree<Integer> n83 = new GeneralTree<>(83);
        GeneralTree<Integer> n90 = new GeneralTree<>(90);
        GeneralTree<Integer> n33hoja = new GeneralTree<>(33);

        // Nivel 3
        GeneralTree<Integer> n14 = new GeneralTree<>(14);
        GeneralTree<Integer> n12hoja = new GeneralTree<>(12);
        List<GeneralTree<Integer>> hijos33 = new LinkedList<>();
        hijos33.add(n35hoja2);
        hijos33.add(n83);
        hijos33.add(n90);
        hijos33.add(n33hoja);
        GeneralTree<Integer> n33 = new GeneralTree<>(33, hijos33);

        // Nivel 2
        List<GeneralTree<Integer>> hijos18 = new LinkedList<>();
        hijos18.add(n14);
        hijos18.add(n12hoja);
        hijos18.add(n33);
        GeneralTree<Integer> n12intermedio = new GeneralTree<>(12, hijos18);
        List<GeneralTree<Integer>> hijos35 = new LinkedList<>();
        hijos35.add(n35hoja);
        GeneralTree<Integer> n35 = new GeneralTree<>(35, hijos35);

        // Nivel 1
        List<GeneralTree<Integer>> hijos12 = new LinkedList<>();
        hijos12.add(n35);
        hijos12.add(n12intermedio);
        GeneralTree<Integer> n12 = new GeneralTree<>(12, hijos12);
        GeneralTree<Integer> n25a = new GeneralTree<>(25);
        GeneralTree<Integer> n25b = new GeneralTree<>(25);

        // Raíz
        List<GeneralTree<Integer>> hijosRaiz = new LinkedList<>();
        hijosRaiz.add(n12);
        hijosRaiz.add(n25a);
        hijosRaiz.add(n25b);
        GeneralTree<Integer> raiz = new GeneralTree<>(12, hijosRaiz);

        // Verificación
        System.out.println("¿Es árbol de selección? " + ParcialArboles.esDeSeleccion(raiz));
    }
}
