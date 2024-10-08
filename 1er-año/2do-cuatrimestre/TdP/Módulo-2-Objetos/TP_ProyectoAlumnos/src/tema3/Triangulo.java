/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema3;

/**
 *
 * @author gonza
 */
public class Triangulo {
    private double lado1;
    private double lado2;
    private double lado3;
    private String colorRelleno;
    private String colorBorde;
    
    public Triangulo(double unLado1, double unLado2, double unLado3, String unCRelleno, String unCBorde) {
        setLado1(unLado1);
        setLado2(unLado2);
        setLado3(unLado3);
        setColorRelleno(unCRelleno);
        setColorBorde(unCBorde);
    }

    private void setLado1(double unLado1) {
        this.lado1 = unLado1;
    }

    private void setLado2(double unLado2) {
        this.lado2 = unLado2;
    }

    private void setLado3(double unLado3) {
        this.lado3 = unLado3;
    }

    private void setColorRelleno(String unCRelleno) {
        this.colorRelleno = unCRelleno;
    }

    private void setColorBorde(String unCBorde) {
        this.colorBorde = unCBorde;
    }

    public double getLado1() {
        return lado1;
    }

    public double getLado2() {
        return lado2;
    }

    public double getLado3() {
        return lado3;
    }

    public String getColorRelleno() {
        return colorRelleno;
    }

    public String getColorBorde() {
        return colorBorde;
    }
    
    public double calcularPerimetro() {
        double aux = lado1 + lado2 + lado3;
        return aux;
    }
    
    public double calcularArea() {
        double s, aux, area;
        s = ((double)(lado1 + lado2 + lado3) / 2);
        aux = (s*(s-lado1)*(s-lado2)*(s-lado3));
        area = Math.sqrt(aux);
        return area;
    }
    
    
}

