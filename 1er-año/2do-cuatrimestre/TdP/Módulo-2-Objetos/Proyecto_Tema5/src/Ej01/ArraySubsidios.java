/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ej01;

/**
 *
 * @author Gonzalo
 */
public class ArraySubsidios extends Array {
    private Subsidio[] subsidios;
    
    // Constructor.
    public ArraySubsidios(int DF) {
        super(DF);
    }

    // Setters.
    public void generarVector() {
        this.subsidios = new Subsidio[this.getDF()];
    }

    // Getters.
    public Subsidio[] getVector() {
        return this.subsidios;
    }
    
    // Otros métodos.
    public boolean agregarSubsidio(Subsidio unSubsidio) {
        return this.agregarElemento(unSubsidio);
    }
}
