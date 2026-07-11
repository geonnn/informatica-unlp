package objetosdos;

// COMPONENT
public abstract class Topografia {

    public abstract double calcularProporcionAgua();

    public double calcularProporcionTierra() {
        return 1.0 - this.calcularProporcionAgua();
    }
}
