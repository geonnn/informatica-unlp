package objetosdos;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class DecodificadorTest {
    Decodificador decodificador;
    Pelicula thor, capitanAmerica, ironMan, dunkirk, rocky, rambo;

    @BeforeEach
    void setUp() {
        decodificador = new Decodificador();


        thor = new Pelicula("Thor", 2007, 7.9);
        capitanAmerica = new Pelicula("Capitán América", 2016, 7.8);
        ironMan = new Pelicula("Iron Man", 2010, 7.9);
        dunkirk = new Pelicula("Dunkirk", 2017, 7.9);
        rocky = new Pelicula("Rocky", 1976, 8.1);
        rambo = new Pelicula("Rambo", 1979, 7.8);

        thor.addSimilar(capitanAmerica);
        thor.addSimilar(ironMan);
        capitanAmerica.addSimilar(ironMan);
        rocky.addSimilar(rambo);

        decodificador.addPelicula(thor);
        decodificador.addPelicula(capitanAmerica);
        decodificador.addPelicula(ironMan);
        decodificador.addPelicula(dunkirk);
        decodificador.addPelicula(rocky);
        decodificador.addPelicula(rambo);

        decodificador.reproducirPelicula(thor);
        decodificador.reproducirPelicula(rocky);
    }

    @Test
    void testNovedad() {
        List<Pelicula> sugerenciasNovedad = new ArrayList<>();
        sugerenciasNovedad.add(dunkirk);
        sugerenciasNovedad.add(capitanAmerica);
        sugerenciasNovedad.add(ironMan);
        assertEquals(sugerenciasNovedad, decodificador.sugerirPeliculas());
    }

    @Test
    void testSimilaridad() {
        List<Pelicula> sugerenciasSimilaridad = new ArrayList<>();
        sugerenciasSimilaridad.add(capitanAmerica);
        sugerenciasSimilaridad.add(ironMan);
        sugerenciasSimilaridad.add(rambo);
        decodificador.setSugerenciasStrategy(new SimilaridadStrategy());
        assertEquals(sugerenciasSimilaridad, decodificador.sugerirPeliculas());
    }
    @Test
    void testPuntaje() {
        List<Pelicula> sugerenciasPuntaje = new ArrayList<>();
        sugerenciasPuntaje.add(dunkirk);
        sugerenciasPuntaje.add(ironMan);
        sugerenciasPuntaje.add(capitanAmerica);
        decodificador.setSugerenciasStrategy(new PuntajeStrategy());
        assertEquals(sugerenciasPuntaje, decodificador.sugerirPeliculas());
    }
}
