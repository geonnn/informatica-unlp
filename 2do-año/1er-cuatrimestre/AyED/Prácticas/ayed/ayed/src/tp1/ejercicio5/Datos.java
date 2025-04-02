package tp1.ejercicio5;

public class Datos {
	private int max;
	private int min;
	private double prom;
	
	public int getMax() {
		return max;
	}
	public void setMax(int max) {
		this.max = max;
	}
	public int getMin() {
		return min;
	}
	public void setMin(int min) {
		this.min = min;
	}
	public double getProm() {
		return prom;
	}
	public void setProm(double prom) {
		this.prom = prom;
	}
	public String ToString() {
		return ("\nMáx: " + this.getMax() +
				"\nMín: " + this.getMin() +
				"\nProm: " + this.getProm());
	}
}
