/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema1;

//Paso 1. importar la funcionalidad para generar datos aleatorios
import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

public class Ej03Matrices {

    public static void main(String[] args) {
	//Paso 2. iniciar el generador aleatorio
        GeneradorAleatorio.iniciar();
	 
        //Paso 3. definir la matriz de enteros de 5x5 e iniciarla con nros. aleatorios 
        int[][] matriz = new int[5][5];
        int i, j;
        for (i=0;i<5;i++)
            for (j=0; j<5; j++)
                matriz[i][j] = GeneradorAleatorio.generarInt(10);
    
        //Paso 4. mostrar el contenido de la matriz en consola
        System.out.print("Elementos de la matriz: ");
        System.out.println();
        for (i=0; i<5; i++) {
            for (j=0; j<5; j++) {
                System.out.print(matriz[i][j] + " ");
            }
            System.out.println();
        }
    
        //Paso 5. calcular e informar la suma de los elementos de la fila 1
        int fila = 2, suma = 0;
        for (j=0; j<5; j++)
            suma += matriz[fila][j];
        System.out.println("Suma de la fila " + fila + ": " + suma);
    
        //Paso 6. generar un vector de 5 posiciones donde cada posición j contiene la suma de los elementos de la columna j de la matriz. 
        //        Luego, imprima el vector.
        int [] vector = new int[5];
        for (i=0; i<5; i++)
            vector[i] = 0; // Inicializo el vector.
        for (i=0; i<5; i++)
            for (j=0; j<5; j++)
                vector[i] += matriz[j][i];
        System.out.print("Vector suma de columnas: ");
        for (i=0; i<5; i++)
            System.out.print(vector[i] + " ");
        
        //Paso 7. lea un valor entero e indique si se encuentra o no en la matriz. En caso de encontrarse indique su ubicación (fila y columna)
        //   y en caso contrario imprima "No se encontró el elemento".
        System.out.println();
        System.out.print("Buscar valor en la matriz: ");
        int valor = Lector.leerInt();
        boolean encontre = false;
        i = 0;
        while ((i < 5) && (!encontre)) {
            j = 0;
            while ((j < 5) && (!encontre)) {
                if (matriz[i][j] == valor) {
                    encontre = true;
                    System.out.println("El elemento estaba en la fila " + (i + 1) + " y la columna " + (j + 1));
                }
                j++;
            }
            i++;
        }
        if (!encontre)
            System.out.println("No se encontró el elemento.");
    }
}
