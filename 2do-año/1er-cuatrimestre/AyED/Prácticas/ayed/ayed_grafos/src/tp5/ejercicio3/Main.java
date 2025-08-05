package tp5.ejercicio3;

import java.util.LinkedList;

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

		grafo.connect(caba, rosario);
		grafo.connect(caba, santaFe);
		grafo.connect(rosario, cordoba);
		grafo.connect(santaFe, cordoba);
		grafo.connect(cordoba, mendoza);
		grafo.connect(cordoba, sanLuis);
		grafo.connect(mendoza, sanJuan);
		grafo.connect(sanLuis, sanJuan);

		Mapa mapa = new Mapa(grafo);

		System.out.println("Camino de CABA a San Juan:");
		System.out.println(mapa.devolverCamino("CABA", "San Juan"));

		System.out.println("Camino de Rosario a Mendoza:");
		System.out.println(mapa.devolverCamino("Rosario", "Mendoza"));

		System.out.println("Camino de CABA a Ushuaia (inexistente):");
		System.out.println(mapa.devolverCamino("CABA", "Ushuaia"));
		
		System.out.println();
		System.out.println("----------------------");
		System.out.println();
		
		LinkedList<String> ciudades = new LinkedList<String>();
		ciudades.add("Mendoza");
		System.out.println("Camino de CABA a San Juan exceptuando Mendoza:");
		System.out.println(mapa.devolverCaminoExceptuando("CABA", "San Juan", ciudades));
		
		System.out.println();
		System.out.println("----------------------");
		System.out.println();
		
		
	}
}
