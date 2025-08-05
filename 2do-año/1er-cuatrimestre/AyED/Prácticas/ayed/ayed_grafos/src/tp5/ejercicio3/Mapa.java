package tp5.ejercicio3;

import java.util.LinkedList;
import java.util.List;

import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

public class Mapa {
	
	Graph<String> grafo;
	
	public Mapa(Graph<String> grafo) {
		this.grafo = grafo;
	}
	
	
	// Retorna la lista de ciudades que se deben atravesar para ir de ciudad1 a ciudad2 en caso de que se pueda llegar, si no retorna la lista vacía.
	// (Sin tener en cuenta el combustible).
	public List<String> devolverCamino(String ciudad1, String ciudad2) {
		
		List<String> result = new LinkedList<>();
		if (grafo != null && !grafo.isEmpty()) {
				
			Vertex<String> orig = grafo.search(ciudad1);
			Vertex<String> dest = grafo.search(ciudad2);
			
			if (orig != null && dest != null) {
				boolean[] marcas = new boolean[grafo.getSize()];
				dC(orig, ciudad2, marcas, result, new LinkedList<>());
			}
		}
		return result;
	}
	
	private void dC(Vertex<String> vAct, String dest, boolean[] marcas, List<String> result, List<String> caminoParcial) {
		
		int posAct = vAct.getPosition();
		marcas[posAct] = true;
		caminoParcial.add(vAct.getData());
		
		if (vAct.getData().equals(dest)) {
			result.clear();
			result.addAll(caminoParcial);
			return;
		}
		
		for (Edge<String> e: this.grafo.getEdges(vAct)) {
			
			Vertex<String> v = e.getTarget();
			if (!marcas[v.getPosition()])
				dC(v, dest, marcas, result, caminoParcial);
		}
		
		marcas[posAct] = false;
		caminoParcial.remove(caminoParcial.size()-1);
	}
	
	
	// Retorna la lista de ciudades que forman un camino desde ciudad1 a ciudad2, sin pasar por las ciudades que están contenidas en la lista ciudades pasada por parámetro, si no existe camino retorna la lista vacía.
	// (Sin tener en cuenta el combustible).
	// Se asume que origen y destino no existen en la lista de ciudades a evitar.
	public List<String> devolverCaminoExceptuando(String ciudad1, String ciudad2, List<String> ciudades) {
		
		List<String> result = new LinkedList<>();
		if (grafo != null && !grafo.isEmpty()) {
			
			Vertex<String> orig = grafo.search(ciudad1);
			Vertex<String> dest = grafo.search(ciudad2);
			
			if (orig != null && dest != null) {
				boolean[] marcas = new boolean[grafo.getSize()];
				dCExc(orig, ciudad2, marcas, ciudades, result, new LinkedList<>());
			}
		}
		return result;
	}
	
	private void dCExc(Vertex<String> vAct, String dest, boolean[] marcas, List<String> ciudadesAEvitar, List<String> result, List<String> caminoParcial) {
		
		int posAct = vAct.getPosition();
		marcas[posAct] = true;
		
		if (ciudadesAEvitar.contains(vAct.getData()))
			return;
			
		caminoParcial.add(vAct.getData());
		
		if (vAct.getData().equals(dest)) {
			result.clear();
			result.addAll(caminoParcial);
			return;
		}
		
		for (Edge<String> e: this.grafo.getEdges(vAct)) {
			
			Vertex<String> v = e.getTarget();
			if (!marcas[v.getPosition()])
				dCExc(v, dest, marcas, ciudadesAEvitar, result, caminoParcial);
		}
		
		marcas[posAct] = false;
		caminoParcial.remove(caminoParcial.size()-1);
	}
	
	
	// Retorna la lista de ciudades que forman el camino más corto para llegar de ciudad1 a ciudad2, si no existe camino retorna la lista vacía.
	// (Las rutas poseen la distancia).
	public List<String> caminoMasCorto(String ciudad1, String ciudad2) {
		
		List<String> result = new LinkedList<>();
		if (grafo != null && !grafo.isEmpty()) {
			
			Vertex<String> orig = grafo.search(ciudad1);
			Vertex<String> dest = grafo.search(ciudad2);
			
			if (orig != null && dest != null) {
				boolean[] marcas = new boolean[grafo.getSize()];
				double[] menorDist = {Double.MAX_VALUE};
				camMasCorto(orig, ciudad2, marcas, result, new LinkedList<>(), 0, menorDist);
				System.out.println("menorDist: " + menorDist[0]);
			}
		}
		return result;
	}
	
	// primer camino más corto.
	private void camMasCorto(Vertex<String> vAct, String dest, boolean[] marcas, List<String> result, List<String> caminoParcial, double distAct, double[] menorDist) {
		
		// Si la distancia actual ya es más grande (o igual) que la menor distancia obtenida no se sigue por este camino.
		if (distAct >= menorDist[0])
			return;
				
		int posAct = vAct.getPosition();
				
		// En este punto:
		// distancia actual < menor distancia. Se agrega el vértice y sigue el curso como cualquier otro.
		marcas[posAct] = true;
		caminoParcial.add(vAct.getData());
		
		if (vAct.getData().equals(dest)) {
			
			menorDist[0] = distAct;
			result.clear();
			result.addAll(caminoParcial);
		}
		else {
			for (Edge<String> e: this.grafo.getEdges(vAct)) {
				
				Vertex<String> v = e.getTarget();
				// if (!marcas[v.getPosition()] && distAct+e.getWeight() < menorDist[0]) ¿podría evaluarse la distancia acá y sacar el primer if?
				if (!marcas[v.getPosition()])
					camMasCorto(v, dest, marcas, result, caminoParcial, (distAct + e.getWeight()), menorDist);
			}
		}
		
		marcas[posAct] = false;
		caminoParcial.remove(caminoParcial.size()-1);
	}
	
	
	// Retorna la lista de ciudades que forman un camino para llegar de ciudad1 a ciudad2.
	// El auto no debe quedarse sin combustible y no puede cargar. Si no existe camino retorna la lista vacía.
	public List<String> caminoSinCargarCombustible(String ciudad1, String ciudad2, int tanqueAuto) {
		
		List<String> result = new LinkedList<>();
		if (grafo != null && !grafo.isEmpty()) {
			
			Vertex<String> orig = grafo.search(ciudad1);
			Vertex<String> dest = grafo.search(ciudad2);
			
			if (orig != null && dest != null) {
				boolean[] marcas = new boolean[grafo.getSize()];
				double[] menorDist = {Double.MAX_VALUE};
				camSinCargar(orig, ciudad2, marcas, result, new LinkedList<>(), 0, menorDist);
				System.out.println("menorDist: " + menorDist[0]);
			}
		}
		return result;
	}
	
	private void camSinCargar(Vertex<String> vAct, String dest, boolean[] marcas, List<String> result, List<String> caminoParcial) {
		
	}
	
	
	// Retorna la lista de ciudades que forman un camino para llegar de ciudad1 a ciudad2 teniendo en cuenta que el auto debe cargar la menor cantidad de veces.
	// El auto no se debe quedar sin combustible en medio de una ruta, además puede completar su tanque al llegar a cualquier ciudad.
	// Si no existe camino retorna la lista vacía.
	public List<String> caminoConMenorCargaDeCombustible(String ciudad1, String ciudad2, int tanqueAuto) {
		
		List<String> result = new LinkedList<>();
		if (grafo != null && !grafo.isEmpty()) {
			
		}
		return result;
	}
	
}
