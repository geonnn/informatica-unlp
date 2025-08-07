package tp5.ejercicioMaxGradoSeparacion;

import tp1.ejercicio8.Queue;
import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

// En nuestro interconectado mundo se especula que dos personas cualesquiera están relacionados entre sí a lo sumo por 6 grados de separación. En este problema, debemos realizar un método para encontrar el máximo grado de separación en una red de personas, donde una arista entre dos personas representa la relación de conocimiento entre ellas, la cual es simétrica.
// Entre dos personas, el grafo de separación es el mínimo número de relaciones que son necesarias para conectarse entre ellas. Si en la red hay dos personas que no están conectadas por una cadena de relaciones, el grafo de separación entre ellas se considerará igual a -1 En una red, el máximo grado de separación es el mayor grado de separación entre dos personas cualesquiera de la red.
// Implemente en JAVA una clase llamada gradosDeSeparacion cumpliendo la siguiente especificación: maximoGradoDeSeparacion(Grafo<String> grafo): int retorna el máximo grafo de separación del grafo recibido como parámetro. Si el grafo hubiera dos personas cualesquiera que no están conectadas por una cadena de relaciones entonces retorna 0.

public class GradosDeSeparacion {
	
	public int maximoGradoDeSeparacion(Graph<String> grafo) {
		
		int maxGrado = 0;
		if (grafo != null && !grafo.isEmpty()) {
			for (Vertex<String> v: grafo.getVertices()) {
				maxGrado = Math.max(maxGrado, bfs(grafo, v));
			}
		}
		return maxGrado;
	}
	
	private int bfs(Graph<String> g, Vertex<String> origen) {
		
		Queue<Vertex<String>> q = new Queue<Vertex<String>>();
		boolean[] marcas = new boolean[g.getSize()];
		int grado = 0;
		
		marcas[origen.getPosition()] = true;
		q.enqueue(origen);
		q.enqueue(null);
		
		while (!q.isEmpty()) {
			
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
					grado++;
					q.enqueue(null);
				}
			}
		}
		return grado;
	}
}
