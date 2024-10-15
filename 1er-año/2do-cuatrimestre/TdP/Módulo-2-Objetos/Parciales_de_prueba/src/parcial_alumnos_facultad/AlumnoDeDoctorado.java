/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package parcial_alumnos_facultad;

/**
 *
 * @author Gonzalo
 */
public class AlumnoDeDoctorado extends Alumno {
    private String titulo;
    private String univOrigen;

    public AlumnoDeDoctorado(String titulo, String univOrigen, int DNI, String nombre, int maxMaterias) {
        super(DNI, nombre, maxMaterias);
        this.setTitulo(titulo);
        this.setUnivOrigen(univOrigen);
    }

    private void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    private void setUnivOrigen(String univOrigen) {
        this.univOrigen = univOrigen;
    }

    private String getTitulo() {
        return titulo;
    }

    private String getUnivOrigen() {
        return univOrigen;
    }
    
    public String toStringSubclases() {
        return this.getTitulo() + "; " + this.getUnivOrigen(); 
    }
}
