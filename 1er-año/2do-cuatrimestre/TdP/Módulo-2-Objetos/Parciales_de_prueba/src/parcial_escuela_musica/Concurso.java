/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package parcial_escuela_musica;

/**
 *
 * @author Gonzalo
 */
public class Concurso {
    private final int cantGeneros = 5;
    private int aluPorGenero;
    private Genero[] vecGeneros;

    public Concurso(int cantAlumnos) {
        this.setAluPorGenero(cantAlumnos);
        this.setVecGeneros();
    }

    private void setAluPorGenero(int aluPorGenero) {
        this.aluPorGenero = aluPorGenero;
    }
    
    private void setVecGeneros() {
        int dimF = this.getCantGeneros();
        
        this.vecGeneros = new Genero[dimF];
        for (int i = 0; i < dimF; i++)
            setGenero(i, new Genero(this.getAluPorGenero()));
    }
    
    private void setGenero(int i, Genero gen) {
        this.vecGeneros[i] = gen;
    }

    private int getAluPorGenero() {
        return this.aluPorGenero;
    }
    
    private Genero[] getVecGeneros() {
        return this.vecGeneros;
    }
    
    private int getCantGeneros() {
        return cantGeneros;
    }
    
    public void inscribirAlumno(Alumno alu, int gen) {
        this.getVecGeneros()[gen].agregarAlumno(alu);
    }
    
    public void asignarPuntaje(String nomAl, int punt) {
        for (int i = 0; i < this.getCantGeneros(); i++)
            
    }
    
}
