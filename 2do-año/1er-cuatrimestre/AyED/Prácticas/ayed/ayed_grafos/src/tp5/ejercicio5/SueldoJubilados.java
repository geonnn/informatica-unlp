package tp5.ejercicio5;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import tp1.ejercicio8.Queue;
import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

// Ejercicio 5 El Banco Itaú se suma a las campañas "QUEDATE EN CASA" lanzando un programa para acercar el sueldo a los jubilados hasta sus domicilios. Para ello el banco cuenta con información que permite definir un grafo de personas donde la persona puede ser un jubilado o un empleado del banco que llevará el dinero. Se necesita armar la cartera de jubilados para cada empleado repartidor del banco, incluyendo en cada lista, los jubilados que vivan un radio cercano a su casa y no hayan percibido la jubilación del mes. Para ello, implemente un algoritmo que dado un Grafo<Persona> retorne una lista de jubilados que se encuentren a una distancia menor a un valor dado del empleado Itaú (grado de separación del empleado Itaú). El método recibirá un Grafo<Persona>, un empleado y un grado de separación/distancia y debe retornar una lista de hasta 40 jubilados que no hayan percibido la jubilación del mes y se encuentre a una distancia menor a recibido como parámetro.

public class SueldoJubilados {
	
	public static List<Persona> cartera(Graph<Persona> grafo, String nomEmpleado, int grado, int maxJubilados) {
		
		List<Persona> result = new LinkedList<Persona>();
		if (grafo != null && !grafo.isEmpty()) {
			Vertex<Persona> emp = buscarEmpleado(grafo, nomEmpleado);
			if (emp != null)
				carteraPrivate(grafo, emp, grado, maxJubilados, result);
		}
		return result;
	}
	
	private static void carteraPrivate(Graph<Persona> grafo, Vertex<Persona> origen, int grado, int maxJubilados, List<Persona> listaJubilados) {
		
		int gradoIn = grado;
		Queue<Vertex<Persona>> q = new Queue<Vertex<Persona>>();
		boolean[] marcas = new boolean[grafo.getSize()];
		
		q.enqueue(origen);
		q.enqueue(null);
		
		marcas[origen.getPosition()] = true;
		
		while (!q.isEmpty() && grado > 0 && listaJubilados.size() < maxJubilados) {
			
			Vertex<Persona> vPer = q.dequeue();
			
			if (vPer != null) {
				
				Persona p = vPer.getData();
				System.out.println("Visitando: " + p.getNombre());
				
				// cumple = isJubilado && no cobró.
				System.out.println(" - " + p.getNombre() + " | Grado: " + (gradoIn-grado) + " | Jubilado: " + p.isJubilado() + " | cobró este mes: " + p.cobroElMes());
				if (vPer.getData().cumple())
					listaJubilados.add(vPer.getData());
				
				// Encolar adyacentes:
				Iterator<Edge<Persona>> it = grafo.getEdges(vPer).iterator();
				while (it.hasNext() && listaJubilados.size() < maxJubilados) {
					Edge<Persona> e = it.next();
					int m = e.getTarget().getPosition();
					if (!marcas[m]) {
						marcas[m] = true;
						q.enqueue(e.getTarget());
					}
				}
			}
			else {
				if (!q.isEmpty()) {
					grado --;
					q.enqueue(null);
				}
			}
		}
		
	}

	private static Vertex<Persona> buscarEmpleado(Graph<Persona> grafo, String nombre) {
		
		List<Vertex<Persona>> lista = grafo.getVertices();
		Iterator<Vertex<Persona>> it = lista.iterator();
		boolean found = false;
		Vertex<Persona> emp = null;
		
		while (it.hasNext() && !found) {
			emp = it.next();
			if (emp.getData().getNombre().equals(nombre))
				found = true;
		}
		return emp;
	}
}
