package ar.edu.unlp.info.oo2.repaso_ejercicio01;

public class Retweet implements Post {

	private final Tweet source;
	
	public Retweet(Tweet source) {
		this.source = source;
	}
	
	public String getText() {
		return this.source.getText();
	}
}
