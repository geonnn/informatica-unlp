package tp5.ejercicioMasterclass;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import tp1.ejercicio8.Queue;
import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

// Implemente la clase Parcial, y el método: public List<???> InvitacionMasterClass (Graph<???> red, String usuario, int distancia, int limite)
// En una red social, cada usuario está conectado con otros mediante relaciones de amistad. Estas relaciones pueden ser representadas como un grafo no dirigido, donde cada nodo representa un usuario y cada arista representa una amistad entre dos usuarios. Un usuario quiere invitar a una masterclass a todos sus contactos que se encuentran hasta cierta distancia de él, pero hay un límite en la cantidad total de personas que puede invitar. El nombre del usuario, la distancia y el límite son parámetros del método. Los nombres de usuarios no se repiten en el grafo. Encuentre todos los usuarios que cumplen con este criterio, priorizando a aquellos que están más cerca del usuario. Una vez que se llegue al limite de usuarios se debe cortar la ejecución. La lista a retornar debe contener en cada elemento: nombre de usuario y la distancia. Nota: Al recorrer la red social, asegúrate de visitar todos los amigos a una distancia menor antes de considerar los amigos a la distancia siguiente.

public class Parcial {
	
	public static List<Usuario> invitacionMasterclass(Graph<String> grafo, String usuario, int distancia, int limite) {
		
		List<Usuario> result = new LinkedList<Usuario>();
		
		if (grafo != null && !grafo.isEmpty()) {
			
			Vertex<String> origen = grafo.search(usuario);
			if (origen != null) {
				masterclass(grafo, origen, distancia, limite, result);
			}
		}	
		return result;
	}
	
	private static void masterclass(Graph<String> grafo, Vertex<String> origen, int distMax, int limite, List<Usuario> result) {
	
		boolean[] marcas = new boolean[grafo.getSize()];
		Queue<Vertex<String>> q = new Queue<Vertex<String>>();
		int dist = 0;
		
		marcas[origen.getPosition()] = true;
		q.enqueue(origen);
		q.enqueue(null);
		
		while (!q.isEmpty() && dist < distMax && result.size() < limite) {
			
			Vertex<String> v = q.dequeue();
			
			if (v!= null) {
				
				Iterator<Edge<String>> it = grafo.getEdges(v).iterator();
				
				while (it.hasNext() && result.size() < limite) {
					Vertex<String> w = it.next().getTarget();
					int m = w.getPosition();
					if (!marcas[m]) {
						marcas[m] = true;
						q.enqueue(w);
						result.add(new Usuario(w.getData(), dist+1));
					}
				}
			}
			else {
				if (!q.isEmpty()) {
					dist++;
					q.enqueue(null);
				}
			}
		}
	}

}
