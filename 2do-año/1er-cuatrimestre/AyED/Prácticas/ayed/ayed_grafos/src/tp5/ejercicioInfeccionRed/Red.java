package tp5.ejercicioInfeccionRed;

import tp1.ejercicio8.Queue;
import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

// Un poderoso e inteligente virus de computadora infecta cualquier computadora en 1 minuto, logrando infectar toda la red de una empresa con cientos de computadoras. Dado un grafo que representa las conexiones entre las computadoras de la empresa, y una computadora ya infectada, escriba un programa en Java que permita determinar el tiempo que demora el virus en infectar el resto de las computadoras. Asuma que todas las computadoras pueden ser infectadas, no todas las computadoras tienen conexión directa entre sí, y un mismo virus puede infectar un grupo de computadoras al mismo tiempo sin importar la cantidad

public class Red {
	
	public static int tiempoDeInfeccion(Graph<String> g, String pcInfectada) {
		
		if (g != null && !g.isEmpty()) {
			Vertex<String> origen = g.search(pcInfectada);
			if (origen != null)
				return tiempoPrivate(g, origen);
		}
		return 0;
	}
	
	private static int tiempoPrivate(Graph<String> g, Vertex<String> origen) {
		
		boolean marcas[] = new boolean[g.getSize()];
		Queue<Vertex<String>> q = new Queue<Vertex<String>>();
		
		int tiempo = 0;
		
		marcas[origen.getPosition()] = true;
		q.enqueue(origen);
		q.enqueue(null);
		
		while (!q.isEmpty()) {
			
			Vertex<String> v = q.dequeue();
			
			if (v != null) {
				
				for (Edge<String> e: g.getEdges(v)) {
					Vertex<String> w = e.getTarget();
					if (!marcas[w.getPosition()]) {
						marcas[w.getPosition()] = true;
						q.enqueue(w);
					}
				}
			}
			else {
				if (!q.isEmpty()) {
					tiempo++;
					q.enqueue(null);
				}
			}
		}
		return tiempo;
	}
}
