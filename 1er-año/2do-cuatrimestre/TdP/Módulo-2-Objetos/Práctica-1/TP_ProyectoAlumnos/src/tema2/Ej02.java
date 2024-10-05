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
        
        GeneradorAleatorio.iniciar();
        
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
        int DL = i;
        int pDNImin = 0, DNImin = Integer.MAX_VALUE;
        int cantMayores65 = 0;
        
        // Print del vector para verificar:
        /*
        for (i=0; i<DL; i++) {
            System.out.println(vecPersonas[i].toString());
        }
        */
        
        for (i=0; i<DL; i++) {
            if ((vecPersonas[i].getEdad()) > 65)
                cantMayores65++;
            if (vecPersonas[i].getDNI() < DNImin){
                DNImin = vecPersonas[i].getDNI();
                pDNImin = i;
            }
        }
        System.out.println("Cantidad de personas mayores a 65 años: " + cantMayores65);
        System.out.println("Persona con DNI más chico: " + vecPersonas[pDNImin].toString());
    }
    
}
