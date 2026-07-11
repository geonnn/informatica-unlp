package objetosdos;

// BUILDER
public abstract class SandwichBuilder {
    protected Sandwich sandwich;

    public SandwichBuilder() {
        this.reset();
    }

    public void reset() {
        this.sandwich = new Sandwich();
    }

    public Sandwich getSandwich() {
        return this.sandwich;
    }

    abstract void agregarPan();
    abstract void agregarAderezo();
    abstract void agregarPrincipal();
    abstract void agregarAdicional();
}
