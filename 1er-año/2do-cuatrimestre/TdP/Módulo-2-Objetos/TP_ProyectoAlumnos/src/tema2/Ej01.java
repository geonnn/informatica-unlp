/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema2;

import PaqueteLectura.Lector;

/**
 *
 * @author gonza
 */
public class Ej01 {
    
    public static void main(String[] args) {
        
        String nombre;
        int DNI;
        int edad;
        
        System.out.println("Ingrese su nombre: ");
        nombre = Lector.leerString();
        System.out.println("Ingrese su DNI: ");
        DNI = Lector.leerInt();
        System.out.println("Ingrese su edad: ");
        edad = Lector.leerInt();
        
        Persona varPersona = new Persona(nombre, DNI, edad);
        
        System.out.println(varPersona.toString());
        
    }
    
}
