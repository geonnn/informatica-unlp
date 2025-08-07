package tp5.ejercicioMafia;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import tp1.ejercicio8.Queue;
import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

public class Parcial {
	
	// “El Paso City”, años 20. Las mafias controlan varios sitios y calles de la ciudad. El intendente que debe desplazarse diariamente en su auto desde su residencia a la municipalidad, está seriamente amenazado. Usted debe ayudar al intendente encontrando la ruta más segura para realizar su traslado diario implementando en Java un método que recibe como parámetro la ciudad, y retorne la ruta que no pase por calles y sitios controlados por la mafia.
	// La ciudad se describe como un conjunto de n sitios y varias calles bidireccionales que unen esos sitios. Cada sitio tiene la información si está controlado por la mafia o no. Lo mismo sucede con cada una de las calles de la ciudad

	public List<Sitio> rutaSegura(Graph<Sitio> g, String residencia, String municipalidad) {
		
		if (g != null && !g.isEmpty()) {
			
			Vertex<Sitio> origen = buscarSitio(g, residencia);
			Vertex<Sitio> dest = buscarSitio(g, municipalidad);
			
			if (origen != null && dest != null)
				return ruta(g, origen, dest);
			
		}
		return new LinkedList<Sitio>();
	}
	
	private List<Sitio> ruta(Graph<Sitio> g, Vertex<Sitio> origen, Vertex<Sitio> dest) {
		
		Queue<Vertex<Sitio>> q = new Queue<Vertex<Sitio>>();
		int n = g.getSize();
		boolean[] marcas = new boolean[n];
		
		int[] anc = new int[n];
		for (int i = 0; i < n; i++)
			anc[i] = -1; // va a ser cond. de corte para reconstruir el camino.
		
		boolean found = false;
		marcas[origen.getPosition()] = true;
		q.enqueue(origen);
		
		while (!q.isEmpty() && !found) {
			Vertex<Sitio> v = q.dequeue(); // es un sito safe.
			
			Iterator<Edge<Sitio>> it = g.getEdges(v).iterator();
			while (it.hasNext() && !found) {
				Edge<Sitio> e = it.next();
				if (e.isSafe()) { // if calle is safe, este método no existe como está implementada la clase Edge pero sería algo así prácticamente.
					Vertex<Sitio> w = e.getTarget();
					int m = w.getPosition();
					if (!marcas[m]) {
						marcas[m] = true;
						if (w.getData().isSafe()) {
							anc[m] = v.getPosition();
							if (w.equals(dest))
								found = true;
							else
								q.enqueue(w);	
						}
					}
				}
			}
		}
		
		List<Sitio> camino = new LinkedList<Sitio>();
		if (found) {
			int pos = dest.getPosition();
			while (pos != -1) {
				camino.addFirst(g.getVertex(pos).getData());
				pos = anc[pos];
			}
		}
		
		return camino;
	}
	
	private Vertex<Sitio> buscarSitio(Graph<Sitio> g, String sitio) {
		
		for (Vertex<Sitio> v: g.getVertices()) {
			if (v.getData().getNombre().equals(sitio))
				return v;
		}
		return null;
	}
}
