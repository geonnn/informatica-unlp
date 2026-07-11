package objetosdos;

// LEAF
public class Tierra extends Topografia {

    @Override
    public double calcularProporcionAgua() {
        return 0;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        return obj instanceof Tierra;
    }
}
