package tp5.ejercicioMasterclass;

import java.util.List;

import tp5.ejercicio1.adjList.AdjListGraph;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

public class Main {

    public static void main(String[] args) {

        Graph<String> grafo = new AdjListGraph<String>();

        Vertex<String> v1 = grafo.createVertex("Lionel");
        Vertex<String> v2 = grafo.createVertex("Ángel");
        Vertex<String> v3 = grafo.createVertex("Rodrigo");
        Vertex<String> v4 = grafo.createVertex("Emiliano");
        Vertex<String> v5 = grafo.createVertex("Julián");
        Vertex<String> v6 = grafo.createVertex("Diego");
        Vertex<String> v7 = grafo.createVertex("Lautaro");
        Vertex<String> v8 = grafo.createVertex("Enzo");
        
        grafo.connect(v1, v2);
        grafo.connect(v1, v3);
        
        grafo.connect(v2, v1);
        grafo.connect(v2, v5);
        grafo.connect(v2, v6);
        grafo.connect(v2, v8);
        
        grafo.connect(v3, v1);
        grafo.connect(v3, v4);
        grafo.connect(v3, v5);
        
        grafo.connect(v4, v3);
        grafo.connect(v4, v7);
        grafo.connect(v4, v8);
        
        grafo.connect(v5, v2);
        grafo.connect(v5, v3);
        grafo.connect(v5, v7);
        
        grafo.connect(v6, v2);
        grafo.connect(v6, v7);
        grafo.connect(v6, v8);
        
        grafo.connect(v7, v4);
        grafo.connect(v7, v5);
        grafo.connect(v7, v6);
        
        grafo.connect(v8, v2);
        grafo.connect(v8, v4);
        grafo.connect(v8, v6);

        String usuario = "Ángel";
        int distancia = 2;
        int limite = 10;

        List<Usuario> invitados = Parcial.invitacionMasterclass(grafo, usuario, distancia, limite);

        System.out.println("Invitados desde " + usuario + " (distancia <= " + distancia + ", límite " + limite + "):");
        for (Usuario u : invitados) {
            System.out.println(u);
        }
    }
}
