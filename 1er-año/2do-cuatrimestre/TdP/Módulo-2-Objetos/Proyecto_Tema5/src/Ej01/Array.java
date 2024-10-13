/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ej01;

/**
 *
 * @author Gonzalo
 */
public abstract class Array {
    private int DF;
    private int DL;

    // Constructor.
    public Array(int DF) {
        this.setDF(DF);
        this.setDL(0);
        this.inicializarVector();
    }
    
    // Setters.
    private void setDF(int DF) {
        this.DF = DF;
    }

    private void setDL(int DL) {
        this.DL = DL;
    }
    
    private void setElemento(Object[] vector, int i, Object elemento) {
        vector[i] = elemento;
    }

    // Getters.
    public int getDF() {
        return this.DF;
    }

    private int getDL() {
        return this.DL;
    }

    // Otros métodos.
    public void inicializarVector() {
        this.generarVector();
        for (int i = 0; i < this.getDF(); i++)
            this.setElemento(this.getVector(), i, null);
    }
    
    public boolean agregarElemento(Object elemento) {
        int dimF = this.getDF();
        int dimL = this.getDL();
        if (dimL < dimF) {
            this.setElemento(this.getVector(), dimL, elemento);
            this.setDL(dimL + 1);
            return true;
        }
        else
            return false;
    }
    
    // Métodos abstractos.
    public abstract Object[] getVector(); // Recibe un vector de cualquier objeto.
                                          // Sirve para recibir el vector de investigadores y subsidios en un mismo método.
    public abstract void generarVector();
}