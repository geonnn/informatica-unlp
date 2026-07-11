package objetosdos;

public class EmpleadoPasante extends Empleado {
    private int examenesRendidos;
    private final double SUELDO_BASICO = 20_000;

    public EmpleadoPasante(boolean casado, int cantHijos, int examenesRendidos) {
        super(casado, cantHijos);
        this.examenesRendidos = examenesRendidos;
    }

    protected double getSueldoBasico() {
        return SUELDO_BASICO;
    }

    @Override
    protected double getSueldoAdicional() {
        return this.examenesRendidos * 2000;
    }
}
