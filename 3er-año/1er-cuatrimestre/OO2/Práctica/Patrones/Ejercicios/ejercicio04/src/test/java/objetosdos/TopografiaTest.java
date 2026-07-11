package objetosdos;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class TopografiaTest {
    Topografia agua, tierra, mixta1, mixta2;

    @BeforeEach
    void setUp() {
        agua = new Agua();
        tierra = new Tierra();
        mixta1 = new Mixta(agua, tierra, agua, tierra);
        mixta2 = new Mixta(agua, tierra, agua, mixta1);
    }

    @Test
    void testCalcularProporcionAgua() {
        assertEquals(1, agua.calcularProporcionAgua());
        assertEquals(0, tierra.calcularProporcionAgua());
        assertEquals(0.5, mixta1.calcularProporcionAgua());
        assertEquals(0.625, mixta2.calcularProporcionAgua());
    }

    @Test
    void testEquals() {
        Topografia t = new Mixta(agua, tierra, agua, tierra);
        assertEquals(mixta1, t);
    }
}
