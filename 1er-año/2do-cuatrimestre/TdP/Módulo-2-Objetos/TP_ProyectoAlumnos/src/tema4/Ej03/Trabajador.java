/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema4.Ej03;

/**
 *
 * @author Gonzalo
 */
public class Trabajador extends Persona {
    private String tarea;

    public Trabajador(String unNombre, int unDNI, int unaEdad, String tarea) {
        super(unNombre, unDNI, unaEdad);
        this.setTarea(tarea);
    }

    public void setTarea(String tarea) {
        this.tarea = tarea;
    }
    
    public String getTarea() {
        return this.tarea;
    }

    public String toString() {
        return super.toString() + " Soy " + this.getTarea() + ".";
    }
    
}
