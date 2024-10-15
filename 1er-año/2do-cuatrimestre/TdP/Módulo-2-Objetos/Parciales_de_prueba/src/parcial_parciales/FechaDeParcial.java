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
public class FechaDeParcial {
    private int dimFSalas;
    private Sala[] vecSalas;
    private int dimFAlumnosPSala;

    public FechaDeParcial(int dimFSalas, int dimFAlumnosPSala) {
        this.setDimFSalas(dimFSalas);
        this.setDimFAlumnosPSala(dimFAlumnosPSala);
        this.setVecSalas();
    }

    private void setDimFSalas(int dimFSalas) {
        this.dimFSalas = dimFSalas;
    }

    private void setVecSalas() {
        int dimF = this.getDimFSalas();
        this.vecSalas = new Sala[dimF];
        for (int i = 0; i < dimF; i++)
            setSala(i, new Sala(this.getDimFAlumnosPSala()));
    }

    private void setDimFAlumnosPSala(int dimFAlumnosPSala) {
        this.dimFAlumnosPSala = dimFAlumnosPSala;
    }
    
    private void setSala(int i, Sala sala) {
        this.vecSalas[i] = sala;
    }

    private int getDimFSalas() {
        return this.dimFSalas;
    }

    private Sala[] getVecSalas() {
        return this.vecSalas;
    }

    private int getDimFAlumnosPSala() {
        return this.dimFAlumnosPSala;
    }
    
    // Obtiene la sala recibida por parámetro desde el vector y envía el alumno al método de dicha sala para agregarlo.
    public void agregarAlumno(int sala, Alumno alu) {
        this.getVecSalas()[sala].agregarAlumno(alu);
    }
    
    public void asignarTemaATodos(int cantTemas) {
        GeneradorAleatorio.iniciar();
        for (int i = 0; i < this.getDimFSalas(); i++) {
            this.getVecSalas()[i].asignarTemaAlumnos(cantTemas);
        }
    }
    
    public String toStringAlumnosTema(int tema) {
        String aux = "";
        for (int i = 0; i < this.getDimFSalas(); i++)
            aux += this.getVecSalas()[i].toStringAlumnosTema(tema);
        return aux;
    }
}
