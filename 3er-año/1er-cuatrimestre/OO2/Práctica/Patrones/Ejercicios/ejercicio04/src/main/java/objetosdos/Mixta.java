package objetosdos;

import java.util.ArrayList;
import java.util.List;

// COMPOSITE
public class Mixta extends Topografia {
    private final List<Topografia> topografias;

    public Mixta(Topografia t1, Topografia t2, Topografia t3, Topografia t4) {
        this.topografias = new ArrayList<>(4);
        this.topografias.add(t1);
        this.topografias.add(t2);
        this.topografias.add(t3);
        this.topografias.add(t4);
    }

    @Override
    public double calcularProporcionAgua() {
        double proporcionAgua = 0;
        for (Topografia t : this.topografias) {
            proporcionAgua += t.calcularProporcionAgua();
        }
        return (proporcionAgua / this.topografias.size());
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (!(obj instanceof Mixta)) return false;
        return this.topografias.equals(((Mixta) obj).topografias);
    }
}
