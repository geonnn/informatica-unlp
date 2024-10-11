/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema4.Ej02;

/**
 *
 * @author Gonzalo
 */
public class Entrenador extends Empleado {
    private int campeonatos;

    public Entrenador(String nombre, double sueldo, int antiguedad, int campeonatos) {
        super(nombre, sueldo, antiguedad);
        setCampeonatos(campeonatos);
    }
    
    private void setCampeonatos(int campeonatos) {
        this.campeonatos = campeonatos;
    }
    
    public int getCampeonatos() {
        return this.campeonatos;
    }
    
    public double calcularEfectividad() {
        return ((double) this.getCampeonatos() / super.getAntiguedad());
    }
    
    public double calcularSueldoIncentivo() {
        int campeonatos = this.getCampeonatos();
        
        if (campeonatos >= 1 && campeonatos <= 4)
            return 5000;
        else if (campeonatos >= 5 && campeonatos <= 10)
            return 30000;
        else if (campeonatos > 10)
            return 50000;
        else
            return 0;
    }
    
    public String toString() {
        return super.toString() +
                " campeonatos por año.";
    }
}
