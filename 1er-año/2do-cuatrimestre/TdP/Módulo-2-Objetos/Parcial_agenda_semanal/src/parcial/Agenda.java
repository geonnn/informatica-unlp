/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package parcial;

/**
 *
 * @author Gonzalo
 */
public class Agenda {
    private final int DIAS = 5;
    private final int TURNOS = 6;
    private Paciente[][] matriz;

    public Agenda() {
        this.setMatriz();
    }

    private void setMatriz() {
        this.matriz = new Paciente[this.getDIAS()][this.getTURNOS()];
        for (int i = 0; i < this.getDIAS(); i++)
            for (int j = 0; j < this.getTURNOS(); j++)
                this.matriz[i][j] = null;
    }

    private int getDIAS() {
        return this.DIAS;
    }

    private int getTURNOS() {
        return this.TURNOS;
    }
    
    private Paciente[][] getMatriz() {
        return this.matriz;
    }
    
    private void setPaciente(Paciente P, int D, int T) {
        this.matriz[D][T] = P;
    }
    
    public void agendarPaciente(Paciente P, int D, int T) {
        this.setPaciente(P, D, T);
        System.out.println("Paciente " + P.getNombre() + " agendado al día " + D + " turno " + T);
    }
    
    public void liberarTurnos(String nom) {
        int D = this.getDIAS();
        int T = this.getTURNOS();
        for (int i = 0; i < D; i++)
            for (int j = 0; j < T; j++)
                if ((this.getMatriz()[i][j]) != null && (this.getMatriz()[i][j].getNombre().equals(nom)))
                    setPaciente(null, i, j);
    }
    
    public boolean tieneTurno(String nom, int D) {
        boolean encontro = false;
        for (int i = 0; i < this.getTURNOS(); i++)
            if ((this.getMatriz()[D][i] != null) && (this.getMatriz()[D][i].getNombre().equals(nom)))
                encontro = true;
        return encontro;
    }
    
}