/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ej01;

/**
 *
 * @author Gonzalo
 */
public class ArrayInvestigadores extends Array {
    private Investigador[] investigadores;
    
    // Constructor.
    public ArrayInvestigadores(int DF) {
        super(DF);
    }
    
    // Setters.
    public void generarVector() {
        this.investigadores = new Investigador[this.getDF()];
    }
    
    // Getters.
    public Investigador[] getVector() {
        return this.investigadores;
    }
    
    // Otros métodos.
    public boolean agregarInvestigador(Investigador unInvestigador) {
        return this.agregarElemento(unInvestigador);
    }
}