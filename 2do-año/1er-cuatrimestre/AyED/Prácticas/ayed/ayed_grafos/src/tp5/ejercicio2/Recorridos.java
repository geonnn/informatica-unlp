package tp5.ejercicio2;

import java.util.LinkedList;
import java.util.List;

import tp1.ejercicio8.Queue;
import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

public class Recorridos<T> {
	
	// O(|V| + |E|)
	public List<T> bfs(Graph<T> grafo) {
		
		List<T> result = new LinkedList<T>();
		if (grafo != null && !grafo.isEmpty()) {
			
			boolean[] marcas = new boolean[grafo.getSize()];
			for (int i = 0; i < grafo.getSize(); i++) {
				if (!marcas[i])
					bfsPrivate(i, grafo, result, marcas);
			}
		}
		return result;
	}
	
	private void bfsPrivate(int i, Graph<T> g, List<T> result, boolean[] marcas) {
		
		Queue<Vertex<T>> q = new Queue<Vertex<T>>();
		q.enqueue(g.getVertex(i));
		marcas[i] = true;
		
		while (!q.isEmpty()) {
			
			Vertex<T> v = q.dequeue();
			result.add(v.getData());
			
			for (Edge<T> e: g.getEdges(v)) {
				int j = e.getTarget().getPosition();
				if (!marcas[j]) {
					marcas[j] = true;
					q.enqueue(e.getTarget());
				}
			}
		}
		
	}

	// O(|V| + |E|)
	public List<T> dfs(Graph<T> grafo) {
		
		List<T> result = new LinkedList<T>();
		if (grafo != null && !grafo.isEmpty()) {
			
			boolean[] marcas = new boolean[grafo.getSize()];
			for (int i = 0; i < grafo.getSize(); i++) {
				if (!marcas[i])
					dfsPrivate(i, grafo, result, marcas);
			}
		}
		return result;
	}
	
	private void dfsPrivate(int i, Graph<T> g, List<T> result, boolean[] marcas) {
		
		marcas[i] = true;
		
		Vertex<T> v = g.getVertex(i);
		result.add(v.getData());
		
		for (Edge<T> e: g.getEdges(v)) {
			int j = e.getTarget().getPosition();
			if (!marcas[j])
				dfsPrivate(j, g, result, marcas);
		}
		
	}
}
