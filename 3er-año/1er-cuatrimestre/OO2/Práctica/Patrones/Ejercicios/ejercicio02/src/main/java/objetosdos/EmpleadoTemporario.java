package objetosdos;

public class EmpleadoTemporario extends Empleado {
    private double horasDeTrabajo;
    private final double SUELDO_BASICO = 20_000;

    public EmpleadoTemporario(boolean casado, int cantHijos, double horasDeTrabajo) {
        super(casado, cantHijos);
        this.horasDeTrabajo = horasDeTrabajo;
    }

    @Override
    protected double getSueldoBasico() {
        return SUELDO_BASICO + this.horasDeTrabajo * 300;
    }

    @Override
    protected double getSueldoAdicional() {
        return this.calcularAdicionalFamiliar();
    }
}
