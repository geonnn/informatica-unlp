/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema4;

/**
 *
 * @author Gonzalo
 */
public class Circulo extends Figura {
    private double radio;
    
    public Circulo(double radio, String colorRelleno, String colorLinea) {
        super(colorRelleno, colorLinea);
        this.setRadio(radio);
    }

    private void setRadio(double radio) {
        this.radio = radio;
    }

    private double getRadio() {
        return radio;
    }
    
    public double calcularPerimetro() {
        //2pi*r
        double per;
        per = (2*Math.PI*this.getRadio());
        return Math.round(per*100.0) / 100.0;
    }
    
    public double calcularArea() {
        //pi*r^2
        double area;
        area = Math.PI*(Math.pow(this.getRadio(), 2));
        return Math.round(area*100.0) / 100.0;
    }
    
    @Override
    public String toString() {
        return super.toString() +
                " Radio: " + this.getRadio();
    }
}
