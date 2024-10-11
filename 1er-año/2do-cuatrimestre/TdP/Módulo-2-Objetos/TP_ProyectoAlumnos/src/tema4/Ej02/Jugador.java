/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema4.Ej02;

/**
 *
 * @author Gonzalo
 */
public class Jugador extends Empleado {
    private int partJugados;
    private int golesAnotados;
    
    public Jugador(String nombre, double sueldo, int antiguedad, int partJugados, int golesAnotados) {
        super(nombre, sueldo, antiguedad);
        setPartJugados(partJugados);
        setGolesAnotados(golesAnotados);
    }

    private void setPartJugados(int partJugados) {
        this.partJugados = partJugados;
    }

    private void setGolesAnotados(int golesAnotados) {
        this.golesAnotados = golesAnotados;
    }

    private int getPartJugados() {
        return this.partJugados;
    }

    private int getGolesAnotados() {
        return this.golesAnotados;
    }
    
    public double calcularEfectividad() {
        double prom = ((double)this.getGolesAnotados() / this.getPartJugados());
        return (Math.round(prom * 100.0) / 100.0);
    }
    
    public double calcularSueldoIncentivo() {
        if (this.calcularEfectividad() > 0.5)
            return super.getSueldoBasico();
        else
            return 0;
    }
    
    public String toString() {
        return super.toString() +
                " goles por partido.";
    }
}
