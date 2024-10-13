/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ej01;

/**
 *
 * @author Gonzalo
 */
public class Investigador {
    private String nombre;
    private int categoria;
    private String especialidad;
    private ArraySubsidios vecSubsidios;

    // Constructor.
    public Investigador(String nombre, int categoria, String especialidad) {
        this.setNombre(nombre);
        this.setCategoria(categoria);
        this.setEspecialidad(especialidad);
        this.setVecSubsidios(5);
    }

    // Setters.
    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    private void setCategoria(int categoria) {
        this.categoria = categoria;
    }

    private void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }
    
    private void setVecSubsidios(int DF) {
        this.vecSubsidios = new ArraySubsidios(DF);
    }

    // Getters.
    public String getNombre() {
        return this.nombre;
    }

    private int getCategoria() {
        return this.categoria;
    }

    private String getEspecialidad() {
        return this.especialidad;
    }
    
    // Otros métodos.
    public void agregarSubsidio(Subsidio unSubsidio) {
        if (this.vecSubsidios.agregarSubsidio(unSubsidio))
            System.out.println("Subsidio motivo " + unSubsidio.getMotivo() + " agregado al investigador " + this.getNombre() + ".");
        else
            System.out.println("El investigador " + this.getNombre() + " no puede solicitar más subsidios.");
    }
}