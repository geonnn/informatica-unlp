/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema4.Ej04;

/**
 *
 * @author Gonzalo
 */
public class Estacion {
    private String nombre;
    private double latitud;
    private double longitud;
    private int cantAnios;
    private int desdeAnio;
    private double[][] matrizTemp;

    public Estacion(String nombre, double latitud, double longitud, int cantAnios, int desdeAnio) {
        this.setNombre(nombre);
        this.setLatitud(latitud);
        this.setLongitud(longitud);
        this.setDesdeAnio(desdeAnio);
        this.setCantAnios(cantAnios);
        this.setMatrizTemp();
    }

    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    private void setLatitud(double latitud) {
        this.latitud = latitud;
    }

    private void setLongitud(double longitud) {
        this.longitud = longitud;
    }

    public void setCantAnios(int cantAnios) {
        this.cantAnios = cantAnios;
    }
    
    private void setDesdeAnio(int desdeAnio) {
        this.desdeAnio = desdeAnio;
    }
    
    private void setMatrizTemp() {
        this.matrizTemp = new double[this.getCantAnios()][12];
    }

    private String getNombre() {
        return nombre;
    }
    private double getLatitud() {
        return latitud;
    }

    private double getLongitud() {
        return longitud;
    }
    
    private int getDesdeAnio() {
        return this.desdeAnio;
    }
    
    private int getCantAnios() {
        return this.cantAnios;
    }
    
    
    
}
