package objetosdos;

public class SubteWay {
    public static void main(String[] args) {
        Cocina c = new Cocina();

        SandwichBuilder clasicoBuilder, vegetarianoBuilder, veganoBuilder, sinTACCBuilder;
        clasicoBuilder = new ClasicoBuilder();
        vegetarianoBuilder = new VegetarianoBuilder();
        veganoBuilder = new VeganoBuilder();
        sinTACCBuilder = new SinTACCBuilder();

        Sandwich clasico, vegetariano, vegano, sinTACC;

        c.setSandwichBuilder(clasicoBuilder);
        c.prepararSandwich();
        clasico = c.getSandwich();

        c.setSandwichBuilder(vegetarianoBuilder);
        c.prepararSandwich();
        vegetariano = c.getSandwich();

        c.setSandwichBuilder(veganoBuilder);
        c.prepararSandwich();
        vegano = c.getSandwich();

        c.setSandwichBuilder(sinTACCBuilder);
        c.prepararSandwich();
        sinTACC = c.getSandwich();

        System.out.println("Precio sánguche clásico: $" + clasico.precio());
        System.out.println("Precio sánguche vegetariano: $" + vegetariano.precio());
        System.out.println("Precio sánguche vegano: $" + vegano.precio());
        System.out.println("Precio sánguche sinTACC: $" + sinTACC.precio());
    }
}
