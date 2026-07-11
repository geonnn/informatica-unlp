package objetosdos;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class EmpleadoTest {

    @Test
    void testSueldoTemporario() {
        Empleado temporario = new EmpleadoTemporario(true, 1, 100);
        double sueldoBasico = 20_000 + 300 * 100;
        double sueldoAdicional = 5000 + 2000;
        double descuento = sueldoBasico * 0.13 + sueldoAdicional * 0.05;
        double sueldoEsperado = sueldoBasico + sueldoAdicional - descuento;
        assertEquals(sueldoEsperado, temporario.sueldo());
    }

    @Test
    void testSueldoPasante() {
        Empleado pasante = new EmpleadoPasante(false, 0, 10);
        double sueldoBasico = 20_000;
        double sueldoAdicional = 2000 * 10;
        double descuento = sueldoBasico * 0.13 + sueldoAdicional * 0.05;
        double sueldoEsperado = sueldoBasico + sueldoAdicional - descuento;
        assertEquals(sueldoEsperado, pasante.sueldo());
    }

    @Test
    void testSueldoPlanta() {
        Empleado planta = new EmpleadoPlanta(true, 2, 5);
        double sueldoBasico = 50_000;
        double sueldoAdicional = 5000 + 4000 + 2000 * 5;
        double descuento = sueldoBasico * 0.13 + sueldoAdicional * 0.05;
        double sueldoEsperado = sueldoBasico + sueldoAdicional - descuento;
        assertEquals(sueldoEsperado, planta.sueldo());
    }
}
