/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema3;

import tema2.Persona;

/**
 *
 * @author Gonzalo
 */
public class Hotel {
    private int maxHabits;
    private Habitacion[] vecHabitaciones;
    
    public Hotel(int cantHabits) {
        setMaxHabitaciones(cantHabits);
        setVecHabitaciones();
        crearHabitaciones();
    }

    private void setMaxHabitaciones(int maxHabits) {
        this.maxHabits = maxHabits;
    }
    
    private void setVecHabitaciones() {
        this.vecHabitaciones = new Habitacion[this.getMaxHabits()];
    }
    
    private Habitacion[] getVecHabitaciones() {
        return this.vecHabitaciones;
    }

    public int getMaxHabits() {
        return this.maxHabits;
    }
    
    // Inicializa habitaciones vacías con precio aleatorio entre 2000 y 8000.
    // Lo usa el constructor, sólo hace falta invocar al constructor y se crean las habitaciones.
    private void crearHabitaciones() {
        for (int i = 0; i<this.getMaxHabits(); i++)
            this.getVecHabitaciones()[i] = new Habitacion();
    }
    
    public void ingresoCliente(int numHab, Persona unCliente) {
        this.getVecHabitaciones()[numHab - 1].ingresarCliente(unCliente);
    }
    
    public void aumentoPrecios(double incremento) {
        for (int i = 0; i < this.getMaxHabits(); i++)
            this.getVecHabitaciones()[i].aumentarCosto(incremento);
    }
    
    public String toString() {
        String aux = "";
        for (int i = 0; i < this.getMaxHabits(); i++) {
            aux += "Habitación " + (i+1) + ": " + this.getVecHabitaciones()[i].toString();
            aux += "\n";
        }
        return aux;
    }
}
