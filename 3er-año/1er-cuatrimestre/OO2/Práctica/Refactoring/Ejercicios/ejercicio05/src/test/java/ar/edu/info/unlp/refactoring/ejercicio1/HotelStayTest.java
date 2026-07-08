package ar.edu.info.unlp.refactoring.ejercicio1;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDate;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class HotelStayTest {
    private HotelStay estadia;
    private LocalDate fehaFin;
    private LocalDate fechaInicio;

    @BeforeEach
    void setUp() throws Exception {
        Hotel hotel = new Hotel(100.0, 0.8);
        this.fehaFin = LocalDate.of(2026, 3, 5);
        this.fechaInicio = LocalDate.of(2026, 3, 1);
        TimePeriod periodo = new TimePeriod(this.fechaInicio, this.fehaFin);
        this.estadia = new HotelStay(400.0, periodo, hotel);
    }

    @Test
    public void testStartDate() {
        assertNotNull(this.estadia.startDate(), "La estadia en hotel debe tener una fecha de inicio");
        assertEquals(this.fechaInicio, this.estadia.startDate());
    }

    @Test
    public void testEndDate() {
        assertNotNull(this.estadia.endDate(), "La estadia en hotel debe tener una fecha de finalización");
        assertEquals(this.fehaFin, this.estadia.endDate());
    }

    @Test
    public void testCost() {
        assertNotNull(this.estadia.getQuote(), "La estadia en hotel debe tener un costo");
        assertEquals(400.0, this.estadia.getQuote());
    }

    @Test
    public void testPriceFactor() {
        // 400 / (4 * 100 * 0.8)
        assertNotNull(this.estadia.priceFactor(), "La estadia en hotel debe tener un factor de precio");
        assertEquals(1.25, this.estadia.priceFactor());
    }

    @Test
    public void testPrice() {
        // 4 * 100 * 0.8
        assertNotNull(this.estadia.price(), "La estadia en hotel debe tener un precio");
        assertEquals(320.0, this.estadia.price());
    }
}
