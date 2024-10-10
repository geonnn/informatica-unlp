/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema3;

import PaqueteLectura.Lector;

/**
 *
 * @author Gonzalo
 */
public class Ej05 {
    
    public static void main(String[] args) {
        double radio;
        String colorRelleno;
        String colorLinea;
        System.out.println("----- CÍRCULO -----");
        System.out.println();
        System.out.println("Ingrese radio: ");
        radio = Lector.leerDouble();
        System.out.println("Ingrese color de relleno: ");
        colorRelleno = Lector.leerString();
        System.out.println("Ingrese color de línea: ");
        colorLinea = Lector.leerString();
        Circulo circulo1 = new Circulo(radio, colorRelleno, colorLinea);
        System.out.println("Perímetro: " + circulo1.calcularPerimetro());
        System.out.println("Área: " + circulo1.calcularArea());
        
    }
    
}
