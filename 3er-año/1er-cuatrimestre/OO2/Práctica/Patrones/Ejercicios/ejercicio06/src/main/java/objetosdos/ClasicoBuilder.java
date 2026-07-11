package objetosdos;

// CONCRETE BUILDER
public class ClasicoBuilder extends SandwichBuilder {

    @Override
    public void agregarPan() {
        this.sandwich.agregarIngrediente(new Ingrediente("Pan brioche", 100));
    }

    @Override
    public void agregarAderezo() {
        this.sandwich.agregarIngrediente(new Ingrediente("Mayonesa", 20));
    }

    @Override
    public void agregarPrincipal() {
        this.sandwich.agregarIngrediente(new Ingrediente("Carne de ternera", 300));
    }

    @Override
    public void agregarAdicional() {
        this.sandwich.agregarIngrediente(new Ingrediente("Tomate", 80));
    }
}
