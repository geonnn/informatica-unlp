/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema3;

/**
 *
 * @author Gonzalo
 */
public class Circulo {
    private double radio;
    private String colorRelleno;
    private String colorLinea;
    
    public Circulo(double radio, String colorRelleno, String colorLinea) {
        this.setRadio(radio);
        this.setColorRelleno(colorRelleno);
        this.setColorLinea(colorLinea);
    }

    private void setRadio(double radio) {
        this.radio = radio;
    }

    private void setColorRelleno(String colorRelleno) {
        this.colorRelleno = colorRelleno;
    }

    private void setColorLinea(String colorLinea) {
        this.colorLinea = colorLinea;
    }

    private double getRadio() {
        return radio;
    }

    private String getColorRelleno() {
        return colorRelleno;
    }

    private String getColorLinea() {
        return colorLinea;
    }
    
    public double calcularPerimetro() {
        //2pi*r
        return (2*Math.PI*this.getRadio());
    }
    
    public double calcularArea() {
        //pi*r^2
        return (Math.PI*(Math.pow(this.getRadio(), 2)));
    }
    
    
    
}
