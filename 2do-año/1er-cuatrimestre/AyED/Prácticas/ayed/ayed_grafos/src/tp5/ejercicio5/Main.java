package tp5.ejercicio5;

import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;
import tp5.ejercicio1.adjList.AdjListGraph;

import java.util.List;

public class Main {

    public static void main(String[] args) {
        
        // Crear grafo de personas
        Graph<Persona> grafo = new AdjListGraph<>(); 

        // Crear personas
        Persona e1 = new Persona("Juan", "Calle Falsa 123", false, false); // empleado
        Persona j1 = new Persona("Ana", "Av. Siempre Viva 742", true, false); // jubilado sin cobrar
        Persona j2 = new Persona("Carlos", "Rivadavia 1000", true, false); // jubilado sin cobrar
        Persona j3 = new Persona("Marta", "Belgrano 200", true, true); // jubilado que ya cobró
        Persona j4 = new Persona("Luis", "Mitre 300", true, false); // jubilado sin cobrar
        Persona e2 = new Persona("Laura", "San Martín 400", false, false); // otro empleado

        // Agregar vértices
        Vertex<Persona> vE1 = grafo.createVertex(e1);
        Vertex<Persona> vJ1 = grafo.createVertex(j1);
        Vertex<Persona> vJ2 = grafo.createVertex(j2);
        Vertex<Persona> vJ3 = grafo.createVertex(j3);
        Vertex<Persona> vJ4 = grafo.createVertex(j4);
        Vertex<Persona> vE2 = grafo.createVertex(e2);
        
        // juan -> ana -> marta -> luis
        //      -> laura -> carlos

        // Conectar relaciones (red social de contactos)
        grafo.connect(vE1, vJ1); // 1° grado
        grafo.connect(vE1, vE2); // 1° grado
        grafo.connect(vE2, vJ2); // 2° grado desde e1
        grafo.connect(vJ1, vJ3); // 2° grado desde e1
        grafo.connect(vJ3, vJ4); // 3° grado desde e1

        // Ejecutar prueba
        int gradoBusqueda = 2;
        int maxJubilados = 40;
        List<Persona> cartera = SueldoJubilados.cartera(grafo, "Juan", gradoBusqueda, maxJubilados);

        // Imprimir resultados
        System.out.println("Jubilados encontrados para el empleado Juan (grado <= " + gradoBusqueda + "):");
        for (Persona p : cartera) {
            System.out.println("- " + p.getNombre() + " | Domicilio: " + p.getDomicilio());
        }
    }
}

