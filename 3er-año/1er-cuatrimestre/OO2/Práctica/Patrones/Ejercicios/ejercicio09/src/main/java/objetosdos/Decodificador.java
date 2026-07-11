package objetosdos;

import java.util.ArrayList;
import java.util.List;

// CONTEXT
public class Decodificador {
    private List<Pelicula> peliculas;
    private List<Pelicula> peliculasReproducidas;
    private SugerenciasStrategy sugerenciasStrategy;

    public Decodificador() {
        this.peliculas = new ArrayList<>();
        this.peliculasReproducidas = new ArrayList<>();
        // por defecto configuro el decodificador con la estrategia de novedad:
        setSugerenciasStrategy(new NovedadStrategy());
    }

    public void setSugerenciasStrategy(SugerenciasStrategy sugerenciasStrategy) {
        sugerenciasStrategy.setDecodificador(this);
        this.sugerenciasStrategy = sugerenciasStrategy;
    }

    public void addPelicula(Pelicula p) {
        this.peliculas.add(p);
    }

    public void reproducirPelicula(Pelicula p) {
        if (!this.peliculasReproducidas.contains(p))
            this.peliculasReproducidas.add(p);
    }

    public List<Pelicula> getPeliculasNoReproducidas() {
        return this.peliculas.stream()
                .filter(p -> !this.peliculasReproducidas.contains(p))
                .toList();
    }

    public List<Pelicula> getPeliculasSimilaresAReproducidasNoReproducidas() {
        return this.peliculasReproducidas.stream()
                .flatMap(p -> p.getSimilares().stream())
                .distinct()
                .filter(q -> !this.peliculasReproducidas.contains(q))
                .toList();
    }

    public List<Pelicula> sugerirPeliculas() {
        return this.sugerenciasStrategy.sugerirPeliculas();
    }
}
