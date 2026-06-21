package ar.edu.info.unlp.refactoring.ejercicio1;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class TimePeriod {
    private LocalDate start;
    private LocalDate end;

    public TimePeriod(LocalDate start, LocalDate end) {
        this.start = start;
        this.end = end;
    }

    public long duration() {
        return ChronoUnit.DAYS.between(this.start, this.end);
    }

    public LocalDate start() {
        return this.start;
    }

    public LocalDate end() {
        return this.end;
    }
}