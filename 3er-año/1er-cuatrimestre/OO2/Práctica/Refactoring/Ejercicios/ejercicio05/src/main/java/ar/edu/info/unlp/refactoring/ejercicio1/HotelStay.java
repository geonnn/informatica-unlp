package ar.edu.info.unlp.refactoring.ejercicio1;

public class HotelStay extends Product {
    private double quote;
    private Hotel hotel;

    public HotelStay(double quote, TimePeriod timePeriod, Hotel hotel) {
        this.quote = quote;
        this.timePeriod = timePeriod;
        this.hotel = hotel;
    }

    public double getQuote() {
        return this.quote;
    }

    public void setQuote(double quote) {
        this.quote = quote;
    }

    public double priceFactor() {
        return this.quote / this.price();
    }

    public double price() {
        return this.timePeriod.duration() * this.hotel.nightPrice() * this.hotel.discountRate();
    }
}
