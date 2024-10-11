/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema4;


public abstract class Figura {
    private String colorRelleno;
    private String colorLinea;
   
    public Figura(String unCR, String unCL){
        this.setColorRelleno(unCR);
        this.setColorLinea(unCL);
    }
    
    public String toString(){
        String aux = "Area: " + this.calcularArea() +
                    " Perímetro: " + this.calcularPerimetro() +
                    " CR: "  + this.getColorRelleno() + 
                    " CL: " + this.getColorLinea();             
             return aux;
       }

    
    public String getColorRelleno(){
        return this.colorRelleno;       
    }
    public void setColorRelleno(String unColor){
        this.colorRelleno = unColor;       
    }
    public String getColorLinea(){
        return this.colorLinea;       
    }
    public void setColorLinea(String unColor){
        this.colorLinea = unColor;       
    }
    
    public void despintar() {
        this.setColorLinea("negra");
        this.setColorRelleno("blanco");
    }
    
    public abstract double calcularArea();
    public abstract double calcularPerimetro();
     
}
