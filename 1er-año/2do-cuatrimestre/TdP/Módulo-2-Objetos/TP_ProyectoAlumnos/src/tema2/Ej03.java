/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema2;

import PaqueteLectura.GeneradorAleatorio;

/**
 *
 * @author Gonzalo
 */
public class Ej03 {
    
    private static final int DIAS = 5;
    private static final int TURNOS = 8;
    
    public static void main(String[] args) {
        
        GeneradorAleatorio.iniciar();
        
        Persona[][] matrizCasting = new Persona[DIAS][TURNOS];
        
        int i, j, edad, DNI, DL = 0;
        String nombre;
        
        i = 0;
        nombre = GeneradorAleatorio.generarString(GeneradorAleatorio.generarInt(10) + 1);
        while (DL < (DIAS*TURNOS) && !(nombre.equals("ZZZ"))) {
            j = 0;
            while (DL < (DIAS*TURNOS) && !(nombre.equals("ZZZ")) && (j < TURNOS)) {
                DNI = GeneradorAleatorio.generarInt(99999999 - 10000000 + 1) + 10000000;
                edad = GeneradorAleatorio.generarInt(90);
                matrizCasting[i][j] = new Persona(nombre, DNI, edad);
                DL++;
                j++;
                nombre = GeneradorAleatorio.generarString(GeneradorAleatorio.generarInt(10) + 1);
                //nombre = "ZZZ";
            }
            i++;
        }
        
        System.out.println("DL: " + DL);
        
        int k = 0;
        while (k < DL) {
            i = 0;
            while ((k < DL) && (i < DIAS)) {
                j = 0;
                while ((k < DL) && (i < DIAS) && (j < TURNOS)) {
                    System.out.println("Día " + (i + 1) + " | Turno " + (j + 1) + ": " + matrizCasting[i][j].getNombre());
                    j++;
                    k++;
                }
                i++;
            }
        }
    }
}