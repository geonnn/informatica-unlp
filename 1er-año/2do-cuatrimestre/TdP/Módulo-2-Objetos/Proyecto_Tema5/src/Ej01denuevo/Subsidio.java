/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ej01denuevo;

/**
 *
 * @author Gonzalo
 */
public class Subsidio {
    private double monto;
    private String motivo;
    private boolean otorgado;

    public Subsidio(double monto, String motivo) {
        this.setMonto(monto);
        this.setMotivo(motivo);
        this.setOtorgado(false);
    }
    
    private void setMonto(double monto) {
        this.monto = monto;
    }

    private void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public void setOtorgado(boolean otorgado) {
        this.otorgado = otorgado;
    }

    public double getMonto() {
        return this.monto;
    }

    public String getMotivo() {
        return this.motivo;
    }

    public boolean isOtorgado() {
        return this.otorgado;
    }
    
    
    
}
