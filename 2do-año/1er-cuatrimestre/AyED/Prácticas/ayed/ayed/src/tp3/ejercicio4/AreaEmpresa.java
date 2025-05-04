package tp3.ejercicio4;

public class AreaEmpresa {
	private String id;
	private int latencia;

	public AreaEmpresa(String id, int latencia) {
		this.id = id;
		this.latencia = latencia;
	}
	
	public String getId() {
		return this.id;
	}
	
	public int getLatencia() {
		return this.latencia;
	}
}
