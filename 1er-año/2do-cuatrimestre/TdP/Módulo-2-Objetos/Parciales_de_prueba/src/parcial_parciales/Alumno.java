/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package parcial_parciales;

/**
 *
 * @author Gonzalo
 */
public class Alumno {
    private String nombre;
    private int DNI;
    private int tema;

    public Alumno(String nombre, int DNI) {
        this.setNombre(nombre);
        this.setDNI(DNI);
        this.setTema(-1);
    }

    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    private void setDNI(int DNI) {
        this.DNI = DNI;
    }

    private void setTema(int tema) {
        this.tema = tema;
    }

    private String getNombre() {
        return this.nombre;
    }

    private int getDNI() {
        return this.DNI;
    }

    private int getTema() {
        return this.tema;
    }
    
    public void asignarTema(int tema) {
        this.setTema(tema);
    }
    
    public boolean cmpTema(int tema) {
        return (this.getTema() == tema);
    }

    @Override
    public String toString() {
        return "Alumno{" + "nombre=" + nombre + ", DNI=" + DNI + ", tema=" + tema + '}';
    }
}
