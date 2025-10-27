package ar.edu.unlp.info.oo1.ejercicio17;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class DateLapse {
	
	LocalDate from;
	int sizeInDays;
	
	public DateLapse(LocalDate from, LocalDate to) {
		this.setFrom(from);;
		this.setTo(to);
	}
	
	public void setFrom(LocalDate from) {
		this.from = from;
	}
	
	public void setTo(LocalDate to) {
		this.sizeInDays = (int)ChronoUnit.DAYS.between(this.from, to);
	}
	
	public LocalDate getFrom() {
		return this.from;
	}
	
	public LocalDate getTo() {
		return this.from.plusDays(sizeInDays);
	}
	
	public int sizeInDays() {
		return this.sizeInDays;
	}
	
	// return from <= other <= to
	public boolean includesDate(LocalDate other) {
		return (other.isAfter(this.from) || other.isEqual(this.from)) &&
				(other.isBefore(this.getTo()) || other.isEqual(this.getTo()));
	}
	
	public boolean overlaps(DateLapse dl) {
		return this.includesDate(dl.getFrom()) || this.includesDate(dl.getTo());
	}
}