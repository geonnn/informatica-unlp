/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package parcial_escuela_musica;

/**
 *
 * @author Gonzalo
 */
public class Alumno {
    private String nombre;
    private int edad;
    private String instrumento;
    private int puntaje;

    public Alumno(String nombre, int edad, String instrumento) {
        this.setNombre(nombre);
        this.setEdad(edad);
        this.setInstrumento(instrumento);
        this.setPuntaje(-1);
    }

    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    private void setEdad(int edad) {
        this.edad = edad;
    }

    private void setInstrumento(String instrumento) {
        this.instrumento = instrumento;
    }

    private void setPuntaje(int puntaje) {
        this.puntaje = puntaje;
    }

    private String getNombre() {
        return nombre;
    }

    private int getEdad() {
        return edad;
    }

    private String getInstrumento() {
        return instrumento;
    }

    private int getPuntaje() {
        return puntaje;
    }
    
    
}
