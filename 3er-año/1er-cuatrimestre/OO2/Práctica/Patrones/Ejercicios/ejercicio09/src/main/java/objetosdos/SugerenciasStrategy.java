package objetosdos;

import java.util.List;

// STRATEGY
public abstract class SugerenciasStrategy {
    protected Decodificador decodificador;

    public void setDecodificador(Decodificador decodificador) {
        this.decodificador = decodificador;
    }

    public abstract List<Pelicula> sugerirPeliculas();
}
