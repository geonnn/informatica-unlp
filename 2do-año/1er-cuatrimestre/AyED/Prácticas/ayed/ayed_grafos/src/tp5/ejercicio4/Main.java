package tp5.ejercicio4;

import java.util.LinkedList;

import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;
import tp5.ejercicio1.adjList.AdjListGraph;
import tp5.ejercicio4.VisitaOslo;

public class Main {

	public static void main(String[] args) {
		
		Graph<String> grafo = new AdjListGraph<String>();
		
		Vertex<String> ayuntamiento = grafo.createVertex("Ayuntamiento");
		Vertex<String> parqueBotanico = grafo.createVertex("Parque botánico");
		Vertex<String> munch = grafo.createVertex("Museo Munch");
		Vertex<String> elTigre = grafo.createVertex("El Tigre");
		Vertex<String> laOpera = grafo.createVertex("La Opera");
		Vertex<String> akershus = grafo.createVertex("Fortaleza Akershus");
		Vertex<String> akkerBridge = grafo.createVertex("Akker Bridge");
		Vertex<String> palacioReal = grafo.createVertex("Palacio real");
		Vertex<String> galeria = grafo.createVertex("Galería nacional");
		Vertex<String> holmenkollen = grafo.createVertex("Holmenkollen");
		Vertex<String> parqueVigeland = grafo.createVertex("Parque Vigeland");
		Vertex<String> folkMuseum = grafo.createVertex("Folk Museum");
		Vertex<String> fram = grafo.createVertex("Museo Fram");
		Vertex<String> museoBarcoPolar = grafo.createVertex("Museo del barco polar");
		Vertex<String> museoVikingo = grafo.createVertex("Museo vikingo");

        grafo.connect(ayuntamiento, parqueBotanico, 10);
        grafo.connect(ayuntamiento, elTigre, 15);
        grafo.connect(ayuntamiento, akkerBridge, 20);
        grafo.connect(ayuntamiento, palacioReal, 5);
        
        grafo.connect(parqueBotanico, munch, 1);
        grafo.connect(parqueBotanico, galeria, 15);
        
        grafo.connect(munch, elTigre, 15);
        
        grafo.connect(elTigre, laOpera, 5);
        
        grafo.connect(laOpera, akershus, 10);
        
        grafo.connect(galeria, parqueVigeland, 10);
        
        grafo.connect(parqueVigeland, holmenkollen, 30);
        
        grafo.connect(palacioReal, folkMuseum, 5);
        
        grafo.connect(folkMuseum, parqueVigeland, 20);
        
        grafo.connect(akkerBridge, folkMuseum, 30);     
        grafo.connect(akkerBridge, museoVikingo, 30);
        
        grafo.connect(museoVikingo, museoBarcoPolar, 5);
        
        grafo.connect(museoBarcoPolar, fram, 5);
        
        grafo.connect(fram, folkMuseum, 5);
        
        VisitaOslo.paseoEnBici(grafo, "Holmenkollen", 999, new LinkedList<String>());
	}

}
