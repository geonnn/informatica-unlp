/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package parcial_alumnos_facultad;

/**
 *
 * @author Gonzalo
 */
public class Fecha {
    private int dia;
    private int mes;
    private int anio;

    public Fecha(int dia, int mes, int anio) {
        this.setDia(dia);
        this.setMes(mes);
        this.setAnio(anio);
    }

    private void setDia(int dia) {
        if ((1 <= dia) && (dia <= 31))
            this.dia = dia;
        else
            throw new IllegalArgumentException("El día debe ser un número dentro del rango 1 a 31.");
    }

    private void setMes(int mes) {
        if ((1 <= mes) && (mes <= 12))
            this.mes = mes;
        else
            throw new IllegalArgumentException("El mes debe ser un número dentro del rango 1 a 12.");
    }

    private void setAnio(int anio) {
        if ((2000 <= anio) && (anio <= 2024))
            this.anio = anio;
        else
            throw new IllegalArgumentException("El año debe ser un número dentro del rango 2000 a 2024.");
    }

    private int getDia() {
        return this.dia;
    }

    private int getMes() {
        return this.mes;
    }

    private int getAnio() {
        return this.anio;
    }
    
    public String toString() {
        return "Fecha: " + this.getDia() +
                "/" + this.getMes() +
                "/" + this.getAnio();
    }
}
