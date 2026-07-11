package objetosdos;

import java.util.ArrayList;
import java.util.List;

// PRODUCT
public class Sandwich {
    private final List<Ingrediente> ingredientes;

    public Sandwich() {
        this.ingredientes = new ArrayList<>();
    }

    public void agregarIngrediente(Ingrediente ingrediente) {
        this.ingredientes.add(ingrediente);
    }

    public double precio() {
        return this.ingredientes.stream()
                .mapToDouble(i -> i.getPrecio()).sum();
    }
}
