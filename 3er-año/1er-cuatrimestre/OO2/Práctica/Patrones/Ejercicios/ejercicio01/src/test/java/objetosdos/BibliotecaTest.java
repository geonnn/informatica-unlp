package objetosdos;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class BibliotecaTest {
	Biblioteca biblioteca;
    Exporter vorheesExporter;
    Exporter jsonSimpleExporter;

    @BeforeEach
    void setUp() {
        biblioteca = new Biblioteca();
        biblioteca.agregarSocio(new Socio("john", "john@gmail.com", "111"));
        biblioteca.agregarSocio(new Socio("ricardo", "ricardo@gmail.com", "222"));
        vorheesExporter = new VoorheesExporter();
        jsonSimpleExporter = new JSONSimpleAdapter();
    }

    @Test
    void test() {
        // se podría usar JSONParser para testear, pero por ahora lo miro imprimiendo en consola y listo otro día será(?.
        biblioteca.setExporter(vorheesExporter);
        System.out.println(biblioteca.exportarSocios());
        biblioteca.setExporter(jsonSimpleExporter);
        System.out.println(biblioteca.exportarSocios());
    }
}
