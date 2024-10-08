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
public class Ej04 {
    
    private static final int DIAS = 5;
    private static final int TURNOS = 8;
    
    public static void main(String[] args) {
        
        GeneradorAleatorio.iniciar();
        
        Persona[][] matrizCasting = new Persona[DIAS][TURNOS];
        int[] vecDLTurnos = new int[DIAS];
        
        // Inicializo contadores de DLs.
        for (int i=0; i<DIAS; i++)
            vecDLTurnos[i] = 0;
        
        int edad, DNI, dia, DL = 0;
        String nombre;
        
        nombre = GeneradorAleatorio.generarString(3);
        while (DL < (DIAS*TURNOS) && !(nombre.equals("ZZZ"))) {
            DNI = GeneradorAleatorio.generarInt(99999999 - 10000000 + 1) + 10000000;
            edad = GeneradorAleatorio.generarInt(90);
            dia = GeneradorAleatorio.generarInt(DIAS);
            
            // Si el vector de DL de ese día no llegó a la cantidad de turnos totales para ese día, se agrega una persona más en el turno sig.
            if (vecDLTurnos[dia] < TURNOS) {
                matrizCasting[dia][vecDLTurnos[dia]] = new Persona(nombre, DNI, edad);
                DL++;
                vecDLTurnos[dia]++;
            }
            else
                System.out.println(nombre + ", no quedan turnos disponibles para el día " + (dia + 1) + ".");
            
            nombre = GeneradorAleatorio.generarString(3);
            //nombre = "ZZZ";
        }
        
        System.out.println("DL: " + DL);
        
        int i, j, k = 0;
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