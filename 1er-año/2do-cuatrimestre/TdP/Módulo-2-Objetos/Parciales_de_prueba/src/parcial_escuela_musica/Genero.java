/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package parcial_escuela_musica;

/**
 *
 * @author Gonzalo
 */
public class Genero {
    private int cantAlumnos;
    private int DLAlumnos = 0;
    private Alumno[] vecAlumnos;

    public Genero(int cantAlumnos) {
        this.setCantAlumnos(cantAlumnos);
        this.setVecAlumnos();
    }

    private void setCantAlumnos(int cantAlumnos) {
        this.cantAlumnos = cantAlumnos;
    }

    private void setDLAlumnos(int DLAlumnos) {
        this.DLAlumnos = DLAlumnos;
    }
    
    private void setVecAlumnos() {        
        int dimF = this.getCantAlumnos();        
        
        this.vecAlumnos = new Alumno[dimF];
        for (int i = 0; i < dimF; i++)
            this.setAlumno(i, null);
    }

    private void setAlumno(int i, Alumno al) {
        this.vecAlumnos[i] = al;
    }

    private int getCantAlumnos() {
        return this.cantAlumnos;
    }

    private int getDLAlumnos() {
        return this.DLAlumnos;
    }

    private Alumno[] getVecAlumnos() {
        return this.vecAlumnos;
    }
    
    public void agregarAlumno(Alumno alu) {
        int dimL = this.getDLAlumnos();
        
        if (dimL < this.getCantAlumnos()) { // if dimL < dimF.
            this.setAlumno(dimL, alu);
            this.setDLAlumnos(dimL + 1);
        }
        else
            System.out.println("No pueden incorporarse más alumnos a este género.");
    }
}
