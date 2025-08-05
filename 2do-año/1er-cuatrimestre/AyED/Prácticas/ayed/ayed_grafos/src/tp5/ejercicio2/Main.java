package tp5.ejercicio2;

import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;
import tp5.ejercicio1.adjList.AdjListGraph;

public class Main {

	public static void main(String[] args) {
		
		Graph<Integer> grafo = new AdjListGraph<Integer>();
		
		Vertex<Integer> v1 = grafo.createVertex(1);
		Vertex<Integer> v2 = grafo.createVertex(2);
		Vertex<Integer> v3 = grafo.createVertex(3);
		Vertex<Integer> v4 = grafo.createVertex(4);
		Vertex<Integer> v5 = grafo.createVertex(5);
		Vertex<Integer> v6 = grafo.createVertex(6);
		Vertex<Integer> v7 = grafo.createVertex(7);
		
		grafo.connect(v1, v4);
		grafo.connect(v1, v2);
		grafo.connect(v1, v3);
		
		grafo.connect(v2, v5);
		
		grafo.connect(v3, v5);
		
		grafo.connect(v4, v6);
		grafo.connect(v4, v5);
		grafo.connect(v4, v3);
		grafo.connect(v4, v2);
		
		grafo.connect(v5, v7);
		
		grafo.connect(v6, v7);
		grafo.connect(v6, v3);

		System.out.println("grafo creado.");
		System.out.println();
		
		Recorridos<Integer> r = new Recorridos<Integer>();
		
		System.out.println("dfs:");
		System.out.println(r.dfs(grafo));
		
		System.out.println();
		
		System.out.println("bfs:");
		System.out.println(r.bfs(grafo));
	}

}
