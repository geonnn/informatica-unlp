/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema1;

import PaqueteLectura.GeneradorAleatorio;
// import PaqueteLectura.Lector;

/**
 *
 * @author Gonzalo
 */
public class Ej05 {
    
    private static final int CLIENTES = 5;
    private static final int CATEGORIAS = 4;
    
public static void main(String[] args) {
    
    GeneradorAleatorio.iniciar();
    
    int[][] matCalificaciones = new int[CLIENTES][CATEGORIAS];
    
    int i, j;
    for(i=0; i<5; i++)
        for(j=0; j<4; j++) {
            matCalificaciones[i][j] = 1 + GeneradorAleatorio.generarInt(10);
            // System.out.println("cat: " + j + " cli: " + i + " | " + matCalificaciones[i][j]);
        }
    
    // Recorro la matriz por columnas en vez de por filas, en las columnas están las distintas categorías.
    // Para las 4 categorías, recorro las calificaciones de los 5 distintos clientes.
    int total;
    for(j=0; j<4; j++) {
        total = 0;
        for(i=0; i<5; i++) {
            total += matCalificaciones[i][j];
        }
        System.out.println("Promedio de calificación categoría " + j + ": " + ((double) total / CLIENTES) + ".");
    }


}
}