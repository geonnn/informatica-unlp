package ar.edu.unlp.info.oo2.repaso_ejercicio01;

public class Tweet implements Post {

	private final String text;
	
	public Tweet(String text) {
		if (text.length() < 1 || text.length() > 280) {
			throw new IllegalArgumentException("El texto del tweet debe contener entre 1 y 280 caracteres.");
		}
		this.text = text;
	}
	
	public String getText() {
		return this.text;
	}
}
