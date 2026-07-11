package objetosdos;

// LEAF
public class Agua extends Topografia {

    @Override
    public double calcularProporcionAgua() {
        return 1;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        return obj instanceof Agua;
    }
}
