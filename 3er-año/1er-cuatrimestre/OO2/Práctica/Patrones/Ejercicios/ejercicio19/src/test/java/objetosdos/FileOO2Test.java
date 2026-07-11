package objetosdos;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;

public class FileOO2Test {
    FileComponent file;

    @BeforeEach
    void setUp() {
        file = new FileOO2("file1", ".pdf", "10MB", LocalDateTime.now(), LocalDateTime.now(), "rw");
    }

    @Test
    void test() {
        System.out.println(file.prettyPrint());

        // ej 1 consigna:
        FileComponent conExtension = new ExtensionDecorator(file);
        System.out.println(conExtension.prettyPrint());

        // ej 2 consigna:
        FileComponent conFechaYExtension = new ExtensionDecorator(new FechaCreacionDecorator(file));
        System.out.println(conFechaYExtension.prettyPrint());

        // ej 3 consigna:
        FileComponent conNomTamPermisosExtension = new ExtensionDecorator(new PermisosDecorator(new TamanioDecorator(file)));
        System.out.println(conNomTamPermisosExtension.prettyPrint());
    }
}
