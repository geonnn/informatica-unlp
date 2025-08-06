package tp5.ejercicioPopularidad;

public class Popularidad {

	private int cantUsuarios;
	private boolean popular;
	
	public Popularidad(int cantUsuarios, boolean popular) {
		super();
		this.cantUsuarios = cantUsuarios;
		this.popular = popular;
	}
	
	public int getCantUsuarios() {
		return cantUsuarios;
	}
	public boolean isPopular() {
		return popular;
	}

	@Override
	public String toString() {
		return "Popularidad [cantUsuarios=" + cantUsuarios + ", popular=" + popular + "]";
	}
}
