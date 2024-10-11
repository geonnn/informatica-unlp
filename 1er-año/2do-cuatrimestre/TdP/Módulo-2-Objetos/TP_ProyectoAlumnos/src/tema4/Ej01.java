/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema4;

/**
 *
 * @author Gonzalo
 */
public class Ej01 {
    
    public static void main(String[] args) {
        
        Triangulo tri;
        Circulo circ;
        tri = new Triangulo(10, 20, 15, "rojo", "blanco");
        circ = new Circulo(10, "celeste", "blanco");
        System.out.println("Triángulo: " + tri.toString());
        System.out.println("Círculo: " + circ.toString());
        tri.despintar();
        circ.despintar();
        System.out.println("Triángulo: " + tri.toString());
        System.out.println("Círculo: " + circ.toString());
        
    }
    
}
