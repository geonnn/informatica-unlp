package objetosdos;

import java.util.Comparator;
import java.util.List;

// CONCRETE STRATEGY
public class NovedadStrategy extends SugerenciasStrategy {

    @Override
    public List<Pelicula> sugerirPeliculas() {
        List<Pelicula> noReproducidas = this.decodificador.getPeliculasNoReproducidas();
        return noReproducidas.stream()
                .sorted(Comparator.comparingInt(Pelicula::getAnioEstreno).reversed())
                .limit(3).toList();
    }
}
