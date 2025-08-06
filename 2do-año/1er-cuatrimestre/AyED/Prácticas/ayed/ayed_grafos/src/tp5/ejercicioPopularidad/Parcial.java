package tp5.ejercicioPopularidad;

import tp1.ejercicio8.Queue;
import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

public class Parcial {
	
	public static Popularidad nivelPopularidad(Graph<String> red, String usuario, int distancia, int umbral) {

		if (red != null && !red.isEmpty()) {
			Vertex<String> origen = red.search(usuario);
			if (origen != null)
				return popPriv(red, origen, distancia, umbral);
		}
		return null;
	}
	
	private static Popularidad popPriv(Graph<String> g, Vertex<String> origen, int distObj, int umbral) {
		
		boolean[] marcas = new boolean[g.getSize()];
		Queue<Vertex<String>> q = new Queue<>();
		int dist = 0;
		int count = 0;
		boolean popular = false;
		
		marcas[origen.getPosition()] = true;
		q.enqueue(origen);
		q.enqueue(null);
		
		while (!q.isEmpty() && dist < distObj) {
			
			Vertex<String> v = q.dequeue();
			if (v != null) {
				
				for (Edge<String> e: g.getEdges(v)) {
					Vertex<String> w = e.getTarget();				
					int m = w.getPosition();
					if (!marcas[m]) {
						marcas[m] = true;
						q.enqueue(w);
					}
				}
			}
			else {
				if (!q.isEmpty()) {
					dist++;					
					// la queue no está vacía y ya saqué null
					// quedan en la queue los elementos del nivel a procesar (actual dist, ya aumentado)
					// por lo tanto:
					if (dist == distObj)
						count = q.size();
					
					q.enqueue(null);
				}
			}
		}
		
		if (count >= umbral)
			popular = true;
		
		return new Popularidad(count, popular);
	}

}
