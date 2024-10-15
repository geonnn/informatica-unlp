/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package parcial_alumnos_facultad;

/**
 *
 * @author Gonzalo
 */
public abstract class Alumno {
    private int DNI;
    private String nombre;
    private int DFMaterias;
    private int DLMaterias = 0;
    private Materia[] materiasAprobadas;

    public Alumno(int DNI, String nombre, int maxMaterias) {
        this.setDNI(DNI);
        this.setNombre(nombre);
        this.setDFMaterias(maxMaterias);
        this.setMateriasAprobadas();
    }

    private void setDNI(int DNI) {
        this.DNI = DNI;
    }

    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    private void setDFMaterias(int DFMaterias) {
        this.DFMaterias = DFMaterias;
    }

    private void setDLMaterias(int DLMaterias) {
        this.DLMaterias = DLMaterias;
    }

    private void setMateriasAprobadas() {
        int dimF = this.getDFMaterias(); // Se usa esta variable local para hacer menos llamadas al getter.
        this.materiasAprobadas = new Materia[dimF];
        for (int i = 0; i < dimF; i++)
            this.materiasAprobadas[i] = null;
    }
    
    private boolean setMateria(Materia unaMateria) {
        int dimL = this.getDLMaterias();
        if (dimL < this.getDFMaterias()) {
            this.materiasAprobadas[dimL] = unaMateria;
            this.setDLMaterias(dimL + 1);
            return true;
        }
        else
            return false;
    }

    private int getDNI() {
        return this.DNI;
    }

    private String getNombre() {
        return this.nombre;
    }

    private int getDFMaterias() {
        return this.DFMaterias;
    }

    private int getDLMaterias() {
        return this.DLMaterias;
    }

    private Materia[] getMateriasAprobadas() {
        return this.materiasAprobadas;
    }
    
    public void agregarMateriaAprobada(Materia unaMateria) {
        if (this.setMateria(unaMateria))
            System.out.println("Materia aprobada agregada al alumno.");
        else
            System.out.println("El alumno no puede incorporar más materias aprobadas.");
    }
    
    public boolean estaGraduado() {
        int dimL = this.getDLMaterias();
        
        if (dimL != this.getDFMaterias())
            return false; // Si no cuenta con todas las materias aprobadas devuelve false.
        
        // Si tiene todas aprobadas busca la materia "Tesis".
        for (int i = 0; i < dimL; i++) {
            if (this.getMateriasAprobadas()[i].getNombre().equals("Tesis"))
                return true; 
        }
        return false; // No encontró la materia "Tesis".
    }
    
    public String toString() {
        int dimL = this.getDLMaterias();
        String aux;
        aux = this.getDNI() + "; " +
                this.getNombre() + "; " +
                "Materias aprobadas:";
        for (int i = 0; i < dimL; i++)
            aux += " " + this.getMateriasAprobadas()[i].toString();
        aux += "; " + this.estaGraduado() +
                "; " + this.toStringSubclases();
        return aux;
    }
    
    public abstract String toStringSubclases();
    
}
