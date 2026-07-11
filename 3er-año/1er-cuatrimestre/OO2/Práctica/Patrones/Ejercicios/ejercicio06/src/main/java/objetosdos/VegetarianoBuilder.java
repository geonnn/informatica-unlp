package objetosdos;

// CONCRETE BUILDER
public class VegetarianoBuilder extends SandwichBuilder {

    @Override
    public void agregarPan() {
        this.sandwich.agregarIngrediente(new Ingrediente("Pan con semillas", 120));
    }

    @Override
    public void agregarAderezo() {
        // no lleva aderezo.
    }

    @Override
    public void agregarPrincipal() {
        this.sandwich.agregarIngrediente(new Ingrediente("Provoleta grillada", 200));
    }

    @Override
    public void agregarAdicional() {
        this.sandwich.agregarIngrediente(new Ingrediente("Berenjenas al escabeche", 100));
    }
}
