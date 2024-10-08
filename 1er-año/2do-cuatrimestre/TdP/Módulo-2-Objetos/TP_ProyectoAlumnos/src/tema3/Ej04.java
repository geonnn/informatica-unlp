/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema3;

import PaqueteLectura.GeneradorAleatorio;
import tema2.Persona;

/**
 *
 * @author Gonzalo
 */
public class Ej04 {
    
    private static String[] nombres = {"Gonzalo", "Antonia", "Juan", "Pedro", "María", "Mariana", "Martina", "Dave", "Kurt", "John", "Anthony", "Flea", "Chad", "Cory", "Joe", "Angus"};
    
    public static void main(String[] args) {
        
        GeneradorAleatorio.iniciar();
        
        Hotel hotel1 = new Hotel(50);
        System.out.println(hotel1.toString());
        
        hotel1.aumentoPrecios(10000);
        System.out.println(hotel1.toString());
        
        for (int i = 0; i < 10; i++) {
            Persona cliente = new Persona(nombres[GeneradorAleatorio.generarInt(16)]);
            hotel1.ingresoCliente((GeneradorAleatorio.generarInt(50)+ 1), cliente);
        }
        System.out.println(hotel1.toString());
    }
    
}
