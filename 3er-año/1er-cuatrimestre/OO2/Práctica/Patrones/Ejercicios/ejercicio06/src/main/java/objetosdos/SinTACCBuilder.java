package objetosdos;

// CONCRETE BUILDER
public class SinTACCBuilder extends SandwichBuilder {

    @Override
    public void agregarPan() {
        this.sandwich.agregarIngrediente(new Ingrediente("Pan de chipá", 150));
    }

    @Override
    public void agregarAderezo() {
        this.sandwich.agregarIngrediente(new Ingrediente("Salsa tártara", 18));
    }

    @Override
    public void agregarPrincipal() {
        this.sandwich.agregarIngrediente(new Ingrediente("Carne de pollo", 250));
    }

    @Override
    public void agregarAdicional() {
        this.sandwich.agregarIngrediente(new Ingrediente("Verduras grilladas", 200));
    }
}
