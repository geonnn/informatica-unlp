package objetosdos;

public abstract class Empleado {
    private boolean casado;
    private int cantHijos;

    protected Empleado(boolean casado, int cantHijos) {
        this.casado = casado;
        this.cantHijos = cantHijos;
    }

    protected double sueldo() {
        return this.getSueldoBasico() + this.getSueldoAdicional() - this.getDescuento();
    }

    private double getDescuento() {
        return this.getSueldoBasico() * 0.13 + this.getSueldoAdicional() * 0.05;
    }

    protected boolean isCasado() {
        return this.casado;
    }

    protected int getCantHijos() {
        return this.cantHijos;
    }

    protected double calcularAdicionalFamiliar() {
        double adicionalFamiliar = this.getCantHijos() * 2000;
        if (this.isCasado())
            adicionalFamiliar += 5000;

        return adicionalFamiliar;
    }

    protected abstract double getSueldoBasico();
    protected abstract double getSueldoAdicional();
}
