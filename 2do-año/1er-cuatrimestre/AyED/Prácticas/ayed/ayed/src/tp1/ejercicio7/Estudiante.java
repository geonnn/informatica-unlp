package tp1.ejercicio7;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Estudiante {
	private String nombre;
	private String apellido;
	private int dni;
	
	public Estudiante(String nombre, String apellido, int dni) {
		this.setNombre(nombre);
		this.setApellido(apellido);
		this.setDni(dni);
	}
	
	public static void agregarEstudiante(List<Estudiante> lista, Estudiante est) {
		Iterator<Estudiante> it = lista.iterator();
		boolean existe = false;
		int dniVerificar = est.getDni();
		while (it.hasNext() && (!existe))
			if (it.next().getDni() == dniVerificar)
				existe = true;
		if (!existe) {
			lista.add(est);
			System.out.println("Estudiante agregado exitosamente.");
		}
		else
			System.out.println("El estudiante con DNI " + dniVerificar + " ya existe.");
	}
	
	public static void Estudiantes() {
		List<Estudiante> listaEst = new ArrayList<Estudiante>();
		listaEst.add(new Estudiante("Gonzalo", "Gil", 43860397));
		listaEst.add(new Estudiante("Antonia", "Cabra", 43516586));
		listaEst.add(new Estudiante("Indio", "Solari", 11222333));
		
		List<Estudiante> copiaListaEst = new ArrayList<Estudiante>();
		copiaListaEst.addAll(listaEst);
		
		listaEst.add(new Estudiante("Skay", "Beilinson", 22333444));
		
		System.out.println("Lista original: ");
		for (Estudiante estudiante : listaEst) {
			System.out.println(estudiante.toString());
		}
		System.out.println();
		System.out.println("Lista copia: ");
		for (Estudiante estudiante : copiaListaEst) {
			System.out.println(estudiante.toString());
		}
		
		listaEst.get(0).setDni(44555666);;
		System.out.println();
		
		System.out.println("Lista original: ");
		for (Estudiante estudiante : listaEst) {
			System.out.println(estudiante.toString());
		}
		System.out.println();
		System.out.println("Lista copia: ");
		for (Estudiante estudiante : copiaListaEst) {
			System.out.println(estudiante.toString());
		}
		
		agregarEstudiante(listaEst, new Estudiante("Juan", "Pérez", 22333444));
	}

	public String getNombre() {
		return nombre;
	}

	private void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellido() {
		return apellido;
	}

	private void setApellido(String apellido) {
		this.apellido = apellido;
	}

	public int getDni() {
		return dni;
	}

	public void setDni(int dni) {
		this.dni = dni;
	}
	
	public String toString() {
		return "Nombre: " + this.getNombre() +
				" | Apellido: " + this.getApellido() +
				" | DNI: " + this.getDni();
	}

}
