package objetosdos;

import java.util.Comparator;
import java.util.List;

// CONCRETE STRATEGY
public class PuntajeStrategy extends SugerenciasStrategy {

    @Override
    public List<Pelicula> sugerirPeliculas() {
        List<Pelicula> noReproducidas = decodificador.getPeliculasNoReproducidas();
        return noReproducidas.stream()
                .sorted(Comparator.comparingDouble(Pelicula::getPuntaje)
                        .thenComparingInt(Pelicula::getAnioEstreno)
                        .reversed())
                .limit(3).toList();
    }
}
