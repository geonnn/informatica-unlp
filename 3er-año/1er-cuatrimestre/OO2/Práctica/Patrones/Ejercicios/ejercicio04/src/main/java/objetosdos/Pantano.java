package objetosdos;

// LEAF
public class Pantano extends Topografia {

    @Override
    public double calcularProporcionAgua() {
        return 0.7;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        return obj instanceof Pantano;
    }
}
