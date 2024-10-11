/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema4.Ej02;

/**
 *
 * @author Gonzalo
 */
public abstract class Empleado {
    private String nombre;
    private double sueldoBasico;
    private int antiguedad;

    public Empleado(String nombre, double sueldoBasico, int antiguedad) {
        this.setNombre(nombre);
        this.setSueldoBasico(sueldoBasico);
        this.setAntiguedad(antiguedad);
    }
    
    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    private void setSueldoBasico(double sueldoBasico) {
        this.sueldoBasico = sueldoBasico;
    }

    private void setAntiguedad(int antiguedad) {
        this.antiguedad = antiguedad;
    }

    private String getNombre() {
        return this.nombre;
    }

    public double getSueldoBasico() {
        return this.sueldoBasico;
    }

    public int getAntiguedad() {
        return this.antiguedad;
    }
    
    public abstract double calcularSueldoIncentivo();
    public abstract double calcularEfectividad();
    
    public double calcularSueldoACobrar() {
        return (this.getSueldoBasico() +
               ((this.getSueldoBasico()*0.1) * this.getAntiguedad()) +
               this.calcularSueldoIncentivo());
    }
    
    public String toString() {
        return "Nombre: " + this.getNombre() +
                " Sueldo a cobrar: " + this.calcularSueldoACobrar() +
                " Efectividad: " + this.calcularEfectividad();
    }
}
