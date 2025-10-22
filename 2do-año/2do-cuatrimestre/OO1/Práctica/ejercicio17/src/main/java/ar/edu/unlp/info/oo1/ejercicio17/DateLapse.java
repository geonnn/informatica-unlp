package ar.edu.unlp.info.oo1.ejercicio17;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class DateLapse {
	
	LocalDate from;
	int sizeInDays;
	
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
	
	public boolean includesDate(LocalDate other) {
		return other.isAfter(this.from) && other.isBefore(this.getTo());
	}
}