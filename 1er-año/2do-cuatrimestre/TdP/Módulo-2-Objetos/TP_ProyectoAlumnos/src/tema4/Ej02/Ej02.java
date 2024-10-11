/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema4.Ej02;

/**
 *
 * @author Gonzalo
 */
public class Ej02 {
    
    public static void main(String[] args) {
        
        Jugador messi = new Jugador("Lionel Messi", 1000, 1, 100, 100);
        Entrenador guardiola = new Entrenador("Pep Guardiola", 1000, 1, 10);
        
        System.out.println(messi.toString());
        System.out.println(guardiola.toString());
        
    }
    
}
