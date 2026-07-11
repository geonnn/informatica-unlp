package objetosdos;

// CONCRETE BUILDER
public class VeganoBuilder extends SandwichBuilder {

    @Override
    public void agregarPan() {
        this.sandwich.agregarIngrediente(new Ingrediente("Pan integral", 100));
    }

    @Override
    public void agregarAderezo() {
        this.sandwich.agregarIngrediente(new Ingrediente("Salsa criolla", 20));
    }

    @Override
    public void agregarPrincipal() {
        this.sandwich.agregarIngrediente(new Ingrediente("Milanesa de girgolas", 500));
    }

    @Override
    public void agregarAdicional() {
        // no lleva adicional.
    }
}
