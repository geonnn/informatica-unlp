/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package parcial_alumnos_facultad;

/**
 *
 * @author Gonzalo
 */
public class Materia {
    private String nombre;
    private int nota;
    private Fecha fecha;

    public Materia(String nombre, int nota, Fecha fecha) {
        this.nombre = nombre;
        this.nota = nota;
        this.fecha = fecha;
    }

    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    private void setNota(int nota) {
        this.nota = nota;
    }

    private void setFecha(Fecha fecha) {
        this.fecha = fecha;
    }

    public String getNombre() {
        return this.nombre;
    }

    private int getNota() {
        return this.nota;
    }

    private Fecha getFecha() {
        return this.fecha;
    }
    
    public String toString() {
        return this.getNombre() + ", " + this.getNota() + ", " + this.getFecha();
    }
}
