package objetosdos;

public class EmpleadoPlanta extends Empleado {
    private int anosAntiguedad;
    private final double SUELDO_BASICO = 50_000;

    public EmpleadoPlanta(boolean casado, int cantHijos, int anosAntiguedad) {
        super(casado, cantHijos);
        this.anosAntiguedad = anosAntiguedad;
    }

    protected double getSueldoBasico() {
        return SUELDO_BASICO;
    }

    @Override
    protected double getSueldoAdicional() {
        return this.calcularAdicionalFamiliar() + this.anosAntiguedad * 2000;
    }
}
