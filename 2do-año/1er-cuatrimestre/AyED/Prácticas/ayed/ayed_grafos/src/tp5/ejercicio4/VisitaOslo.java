package tp5.ejercicio4;

import java.util.LinkedList;
import java.util.List;

import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

public class VisitaOslo {

	public static List<String> paseoEnBici(Graph<String> lugares, String destino, int maxTiempo, List<String> lugaresRestringidos) {
		
		// Se asume que origen y destino no están en la lista de restringidos.
		List<String> result = new LinkedList<String>();
		
		if (lugares != null && !lugares.isEmpty()) {
			
			Vertex<String> orig = lugares.search("Ayuntamiento");
			Vertex<String> dest = lugares.search(destino);
			
			if (orig != null && dest != null) {
				boolean[] marcas = new boolean[lugares.getSize()];
				paseo(lugares, orig, destino, marcas, maxTiempo, 0, result, new LinkedList<String>(), lugaresRestringidos);
			}
			
		}
		
		return result;
	}
	
	private static void paseo(Graph<String> grafo, Vertex<String> vAct, String dest, boolean[] marcas, int maxTiempo, int tiempoAct, List<String> result, List<String> caminoParcial, List<String> lugaresRestringidos) {
		
		// ¿esto va si se chequea en la instancia anterior?
		if (tiempoAct > maxTiempo)
			return;
		
		int posAct = vAct.getPosition();
		marcas[posAct] = true;
		
		if (lugaresRestringidos.contains(vAct.getData()))
			return;
		
		caminoParcial.add(vAct.getData());
		
		if (vAct.getData().equals(dest)) {
			result.addAll(caminoParcial);
			return;
		}
		
		for (Edge<String> e: grafo.getEdges(vAct)) {
			Vertex<String> v = e.getTarget();
			int nuevoTiempo = tiempoAct + e.getWeight();
			if (!marcas[v.getPosition()] && (nuevoTiempo < maxTiempo))
				paseo(grafo, v, dest, marcas, maxTiempo, nuevoTiempo, result, caminoParcial, lugaresRestringidos);
		}
			
		marcas[posAct] = false;
		caminoParcial.remove(caminoParcial.size()-1);
	}
}
