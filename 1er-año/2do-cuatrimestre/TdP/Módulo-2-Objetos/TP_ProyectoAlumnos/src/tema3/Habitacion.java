/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema3;

import PaqueteLectura.GeneradorAleatorio;
import tema2.Persona;

/**
 *
 * @author Gonzalo
 */
public class Habitacion {
    private double costoPNoche;
    private boolean estaOcupada;
    private Persona cliente;
    
    public Habitacion() {
        GeneradorAleatorio.iniciar();
        setCostoPNoche(GeneradorAleatorio.generarDouble(8000 - 2000 + 1) + 2000);
        setEstaOcupada(false);
        setCliente(null);
    }
    
    public Habitacion(Persona unCliente) {
        GeneradorAleatorio.iniciar();
        setCostoPNoche(GeneradorAleatorio.generarDouble(8000 - 2000 + 1) + 2000);
        setEstaOcupada(true);
        setCliente(unCliente);
    }

    private void setCostoPNoche(double costoPNoche) {
        this.costoPNoche = costoPNoche;
    }

    private void setEstaOcupada(boolean estaOcupada) {
        this.estaOcupada = estaOcupada;
    }

    private void setCliente(Persona cliente) {
        this.cliente = cliente;
    }

    public double getCostoPNoche() {
        return costoPNoche;
    }

    public boolean isOcupada() {
        return estaOcupada;
    }

    public Persona getCliente() {
        return cliente;
    }
    
    public void ingresarCliente(Persona unCliente) {
        setCliente(unCliente);
        setEstaOcupada(true);
    }
    
    public void aumentarCosto(double unMonto) {
        this.costoPNoche += unMonto;
    }
    
    public String toString() {
        String aux;
        aux = "$" + String.format("%.2f", costoPNoche) + " por noche, ";
        if (estaOcupada) {
            aux += "ocupada. | ";
            aux += "Cliente: " + cliente.toStringDatos();
        }
        else
            aux += "libre.";
        return aux;
        
    }
    
}
