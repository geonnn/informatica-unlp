/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema2;

import PaqueteLectura.GeneradorAleatorio;


public class Persona {
    private String nombre;
    private int DNI;
    private int edad; 
    
    public Persona(String unNombre, int unDNI, int unaEdad){
        nombre = unNombre;
        DNI = unDNI;
        edad = unaEdad; 
    }
    
    // Genera una persona random con el nombre ingresado.
    public Persona(String unNombre) {
        GeneradorAleatorio.iniciar();
        setNombre(unNombre);
        setDNI(GeneradorAleatorio.generarInt((99999999 - 10000000 + 1) + 10000000));
        setEdad(GeneradorAleatorio.generarInt((72) + 18));
    }
    
    public Persona(){
     
    }

    public int getDNI() {
        return DNI;
    }

    public int getEdad() {
        return edad;
    }

    public String getNombre() {
        return nombre;
    }

    public void setDNI(int unDNI) {
        this.DNI = unDNI;
    }

    public void setEdad(int unaEdad) {
        this.edad = unaEdad;
    }

    public void setNombre(String unNombre) {
        this.nombre = unNombre;
    }
    
    public String toString(){
        String aux; 
        aux = "Mi nombre es " + nombre + ", mi DNI es " + DNI + " y tengo " + edad + " años.";
        return aux;
    }
    public String toStringDatos(){
        String aux; 
        aux = "Nombre: " + nombre + ", DNI: " + DNI + ", edad: " + edad + " años.";
        return aux;
    }
}
