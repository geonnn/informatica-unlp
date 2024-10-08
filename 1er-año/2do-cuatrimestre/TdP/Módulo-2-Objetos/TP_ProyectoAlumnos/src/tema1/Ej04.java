/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema1;

import PaqueteLectura.GeneradorAleatorio;
/**
 *
 * @author Gonzalo
 */
public class Ej04 {
    // Constantes:
    private static final int PISOS = 8;
    private static final int OFICINAS = 4;
    
    public static void main(String[] args) {
        
        GeneradorAleatorio.iniciar();
        
        // Declarar matriz:
        int[][] matrizEdificios = new int[PISOS][OFICINAS];
        
        // Inicializar matriz:
        int i, j;
        for (i=0; i<8; i++)
            for (j=0; j<4; j++)
                matrizEdificios[i][j] = 0;
        
        // Llegada de personas:
        int persPiso;
        int persOf;
        persPiso = GeneradorAleatorio.generarInt(8);
        while (persPiso != 8) {
            persOf = GeneradorAleatorio.generarInt(4);
            System.out.println("Piso " + (persPiso + 1) + " oficina " + (persOf + 1) + ".");
            System.out.println();
            matrizEdificios[persPiso][persOf] ++;
            persPiso = GeneradorAleatorio.generarInt(9);
        }
        
        int cant;
        
        for (i=0; i<8; i++) {
            cant = 0;
            System.out.print("Piso " + (i + 1) + ": ");
            for (j=0; j<4; j++) {
                cant += matrizEdificios[i][j];
            }
            System.out.print(cant + " personas.");
            System.out.println("");
        }
    }
}