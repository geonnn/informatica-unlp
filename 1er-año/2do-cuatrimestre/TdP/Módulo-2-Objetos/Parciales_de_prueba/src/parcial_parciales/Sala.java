/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package parcial_parciales;

import PaqueteLectura.GeneradorAleatorio;

/**
 *
 * @author Gonzalo
 */
public class Sala {
    private int dimFAlumnos;
    private int dimLAlumnos = 0;
    private Alumno[] vecAlumnos;

    public Sala(int dimFAlumnos) {
        this.setDimFAlumnos(dimFAlumnos);
        this.setVecAlumnos();
    }

    private void setDimFAlumnos(int dimFAlumnos) {
        this.dimFAlumnos = dimFAlumnos;
    }

    private void setDimLAlumnos(int dimLAlumnos) {
        this.dimLAlumnos = dimLAlumnos;
    }

    private void setVecAlumnos() {
        int dimF = this.getDimFAlumnos();
        this.vecAlumnos = new Alumno[dimF];
        for (int i = 0; i < dimF; i++)
            setAlumno(i, null);
    }
    
    private void setAlumno(int i, Alumno alu) {
        this.vecAlumnos[i] = alu;
    }

    private int getDimFAlumnos() {
        return this.dimFAlumnos;
    }

    private int getDimLAlumnos() {
        return this.dimLAlumnos;
    }

    private Alumno[] getVecAlumnos() {
        return this.vecAlumnos;
    }
    
    public void agregarAlumno(Alumno alumno) {
        int dimL = this.getDimLAlumnos();
        if (dimL < this.getDimFAlumnos()) {
            this.setAlumno(dimL, alumno);
            this.setDimLAlumnos(dimL + 1);
        }
        else
            System.out.println("No hay lugar para el alumno en la sala " + (dimL + 1) + "."); // dimL + 1 para que imprima desde sala 1 en adelante.
    }
    
    public void asignarTemaAlumnos(int cantTemas) {
        for (int i = 0; i < this.getDimLAlumnos(); i++)
            this.getVecAlumnos()[i].asignarTema(GeneradorAleatorio.generarInt(cantTemas) + 1); // Los temas empiezan desde el 1.
    }
    
    public String toStringAlumnosTema(int tema) {
        String aux = "";
        Alumno alu;
        
        for (int i = 0; i < this.getDimLAlumnos(); i++) {
            alu = this.getVecAlumnos()[i];
            if (alu.cmpTema(tema))
                aux += alu.toString();
        }
        return aux;
    }
}
