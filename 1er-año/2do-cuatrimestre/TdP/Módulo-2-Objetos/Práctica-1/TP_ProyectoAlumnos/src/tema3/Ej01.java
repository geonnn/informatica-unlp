/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema3;

import PaqueteLectura.Lector;

/**
 *
 * @author gonza
 */
public class Ej01 {
    
    public static void main(String[] args) {
        
        double lado1, lado2, lado3;
        String colorRelleno, colorBorde;
        
        System.out.println("----- TRIÁNGULO -----");
        System.out.println();
        
        System.out.println("Ingrese longitud del lado 1: ");
        lado1 = Lector.leerDouble();
        System.out.println("Ingrese longitud del lado 3: ");
        lado2 = Lector.leerDouble();
        System.out.println("Ingrese longitud del lado 3: ");
        lado3 = Lector.leerDouble();
        System.out.println("Ingrese color de relleno: ");
        colorRelleno = Lector.leerString();
        System.out.println("Ingrese color del borde: ");
        colorBorde = Lector.leerString();
        
        Triangulo auxTr = new Triangulo(lado1, lado2, lado3, colorRelleno, colorBorde);
        System.out.println(auxTr.getLado1());
        System.out.println(auxTr.getLado2());
        System.out.println(auxTr.getLado3());
        System.out.println(auxTr.getColorRelleno());
        System.out.println(auxTr.getColorBorde());
        
        System.out.println("Perímetro: " + auxTr.calcularPerimetro());
        System.out.println("Área: " + auxTr.calcularArea());
        
    }
    
}
