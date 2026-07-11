package objetosdos;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

// CONTEXT
public class Pelicula {
    private String titulo;
    private int anioEstreno;
    private List<Pelicula> similares;
    private double puntaje;

    public Pelicula(String titulo, int anioEstreno, double puntaje) {
        this.titulo = titulo;
        this.anioEstreno = anioEstreno;
        this.similares = new ArrayList<>();
        this.puntaje = puntaje;
    }

    public void addSimilar(Pelicula p) {
        if (!this.similares.contains(p)) {
            this.similares.add(p);
            p.addSimilar(this);
        }
    }

    public int getAnioEstreno() {
        return this.anioEstreno;
    }

    public double getPuntaje() {
        return this.puntaje;
    }

    public List<Pelicula> getSimilares() {
        return this.similares;
    }
}
