/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema2;

import PaqueteLectura.GeneradorAleatorio;
/**
 *
 * @author gonza
 */
public class Ej02 {
    
    private static final int DF = 15;
    
    public static void main(String[] args) {
        
        Persona[] vecPersonas = new Persona[DF];
        
        int i = 0;
        String nombre;
        int DNI, edad;
        
        edad = GeneradorAleatorio.generarInt(90);
        while (i < 15 && (edad != 0)) {
            nombre = GeneradorAleatorio.generarString(GeneradorAleatorio.generarInt(10) + 1);
            DNI = GeneradorAleatorio.generarInt(99999999 - 10000000 + 1) + 10000000;
            vecPersonas[i] = new Persona(nombre, DNI, edad);
            edad = GeneradorAleatorio.generarInt(90);
            i++;
        }
        
    }
    
}
