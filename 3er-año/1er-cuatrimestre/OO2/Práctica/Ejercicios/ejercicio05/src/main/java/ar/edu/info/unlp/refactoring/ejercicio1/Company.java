package ar.edu.info.unlp.refactoring.ejercicio1;

public class Company {
    private final double price;
    private final double promotionRate;

    public Company(double price, double promotionRate) {
        this.price = price;
        this.promotionRate = promotionRate;
    }

    public double price() {
        return this.price;
    }

    public double promotionRate() {
        return this.promotionRate;
    }
}
