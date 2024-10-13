/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package parcial;

/**
 *
 * @author Gonzalo
 */
public class Paciente {
    private String nombre;
    private boolean obraSocial;
    private double costoSesion;

    public Paciente(String nombre, boolean obraSocial, double costoSesion) {
        this.setNombre(nombre);
        this.setObraSocial(obraSocial);
        this.setCostoSesion(costoSesion);
    }

    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    private void setObraSocial(boolean obraSocial) {
        this.obraSocial = obraSocial;
    }

    private void setCostoSesion(double costoSesion) {
        this.costoSesion = costoSesion;
    }

    public String getNombre() {
        return this.nombre;
    }

    private double getCostoSesion() {
        return this.costoSesion;
    }
    
    private boolean tieneObraSocial() {
        return this.obraSocial;
    }
    
    public String toString() {
        return this.getNombre();
    }
}
