package ar.edu.info.unlp.refactoring.ejercicio1;

import java.time.LocalDate;

public abstract class Product {
    protected TimePeriod timePeriod;

    protected LocalDate startDate() {
        return this.timePeriod.start();
    }

    protected LocalDate endDate() {
        return this.timePeriod.end();
    }
}
