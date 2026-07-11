package objetosdos;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class UnionQuimica extends ElementoQuimico {
    private List<ElementoQuimico> elementos;

    public UnionQuimica(List<ElementoQuimico> elementos) {
        this.elementos = new ArrayList<>();
        this.elementos.addAll(elementos);
    }

    @Override
    public String formula() {
        return this.elementos.stream()
                .map(e -> e.formula()).collect(Collectors.joining());
    }

    @Override
    public int pesoMolecular() {
        return this.elementos.stream()
                .mapToInt(e -> e.pesoMolecular()).sum();
    }

    @Override
    public int carga() {
        return this.elementos.stream()
                .mapToInt(e -> e.carga()).sum();
    }

    @Override
    public boolean esValida() {
        int cantidadMetales = 0;
        for (ElementoQuimico e : this.elementos) {
            if (!e.esValida()) // si aparece alguno que no sea válido corta y retorna false.
                return false;

            if (e.esMetal()) { // si se encuentra más de 1 metal corta y retorna false.
                // para que una unión sea válida no tiene que haber más de 1 metal.
                cantidadMetales++;
                if (cantidadMetales > 1)
                    return false;
            }
        }
        return true;
    }

    @Override
    public boolean esMetal() {
        return false;
    }
}
