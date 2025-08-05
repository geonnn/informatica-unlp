package tp5.ejercicio3;

import java.util.LinkedList;
import java.util.List;

import tp5.ejercicio1.*;
import tp5.ejercicio1.adjList.AdjListGraph;

public class Main {

	public static void main(String[] args) {
		
		Graph<String> grafo = new AdjListGraph<String>();
		
		Vertex<String> caba = grafo.createVertex("CABA");
		Vertex<String> rosario = grafo.createVertex("Rosario");
		Vertex<String> cordoba = grafo.createVertex("Córdoba");
		Vertex<String> mendoza = grafo.createVertex("Mendoza");
		Vertex<String> santaFe = grafo.createVertex("Santa Fe");
		Vertex<String> sanLuis = grafo.createVertex("San Luis");
		Vertex<String> sanJuan = grafo.createVertex("San Juan");

        grafo.connect(caba, rosario, 10);
        grafo.connect(caba, santaFe, 7);
        grafo.connect(rosario, cordoba, 12);
        grafo.connect(santaFe, cordoba, 8);
        grafo.connect(cordoba, mendoza, 15);
        grafo.connect(cordoba, sanLuis, 10);
        grafo.connect(mendoza, sanJuan, 10);
        grafo.connect(sanLuis, sanJuan, 7);

		Mapa mapa = new Mapa(grafo);

		// 1, 2 y 3 funcionando:
		
//		System.out.println("Camino de CABA a San Juan:");
//		System.out.println(mapa.devolverCamino("CABA", "San Juan"));
//
//		System.out.println("Camino de Rosario a Mendoza:");
//		System.out.println(mapa.devolverCamino("Rosario", "Mendoza"));
//
//		System.out.println("Camino de CABA a Ushuaia (inexistente):");
//		System.out.println(mapa.devolverCamino("CABA", "Ushuaia"));
//		
//		System.out.println();
//		System.out.println("----------------------");
//		System.out.println();
//		
//		LinkedList<String> ciudades = new LinkedList<String>();
//		ciudades.add("Mendoza");
//		System.out.println("Camino de CABA a San Juan exceptuando Mendoza:");
//		System.out.println(mapa.devolverCaminoExceptuando("CABA", "San Juan", ciudades));
//		
//		System.out.println();
//		System.out.println("----------------------");
//		System.out.println();
		
		System.out.println("Camino más corto:");
		System.out.println(mapa.caminoMasCorto("CABA", "San Juan"));
		
		
		// 4 y 5:
		
		int tanque = 20;

        System.out.println("---- caminoSinCargarCombustible ----");
        List<String> camino1 = mapa.caminoSinCargarCombustible("CABA", "San Juan", tanque);
        System.out.println("Tanque: " + tanque + " litros");
        System.out.println("Camino sin cargar: " + camino1);

		System.out.println();
        System.out.println("\n---- caminoConMenorCargaDeCombustible ----");
        List<String> camino2 = mapa.caminoConMenorCargaDeCombustible("CABA", "San Juan", tanque);
        System.out.println("Tanque: " + tanque + " litros");
        System.out.println("Camino con menor carga: " + camino2);
		
		
	}
}
