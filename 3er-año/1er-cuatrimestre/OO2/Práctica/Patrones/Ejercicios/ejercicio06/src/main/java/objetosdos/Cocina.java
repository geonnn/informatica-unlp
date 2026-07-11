package objetosdos;

// DIRECTOR
public class Cocina {
    SandwichBuilder builder;

    public void setSandwichBuilder(SandwichBuilder builder) {
        this.builder = builder;
    }

    public void prepararSandwich() {
        if (this.builder == null)
            throw new IllegalArgumentException("Se debe establecer un builder.");
        builder.reset();
        builder.agregarPan();
        builder.agregarAderezo();
        builder.agregarPrincipal();
        builder.agregarAdicional();
    }

    public Sandwich getSandwich() {
        if (this.builder == null)
            throw new IllegalArgumentException("Se debe establecer un builder.");

        return builder.getSandwich();
    }
}
