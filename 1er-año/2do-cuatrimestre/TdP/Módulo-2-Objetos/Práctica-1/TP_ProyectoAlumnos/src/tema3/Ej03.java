/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema3;

/**
 *
 * @author gonza
 */
public class Ej03 {
    
    public static void main(String[] args) {
        
        Estante estante1 = new Estante();
        Libro libro1, libro2, libro3;
        Autor autL1, autL2, autL3;
        autL1 = new Autor("G.R.R.M.", "BioGRRM", "OrigenGRRM");
        libro1 = new Libro("Game of Thrones", "GOTedit", autL1, "ISBN-GOT");
        estante1.agregarLibro(libro1);
        autL2 = new Autor("Aut2", "bioAut2", "origenAut2");
        libro2 = new Libro("Mujercitas", "editMujercitas", 2010, autL2, "ISBN-Mujercitas", 100.50);
        autL3 = new Autor("Paul Auster", "bioAut3", "origenAut3");
        libro3 = new Libro("The New York Trilogy", "EditTNYT", autL3, "ISBN-TNYT");
        estante1.agregarLibro(libro2);
        estante1.agregarLibro(libro3);
        
        System.out.println(estante1.buscarLibro("The New York Trilogy").getPrimerAutor().toString());
        
    }
    
}
