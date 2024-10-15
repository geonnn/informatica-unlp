/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package parcial_alumnos_facultad;

/**
 *
 * @author Gonzalo
 */
public class AlumnoDeGrado extends Alumno {
    private String carrera;

    public AlumnoDeGrado(String carrera, int DNI, String nombre, int maxMaterias) {
        super(DNI, nombre, maxMaterias);
        this.setCarrera(carrera);
    }

    private void setCarrera(String carrera) {
        this.carrera = carrera;
    }

    private String getCarrera() {
        return this.carrera;
    }

    public String toStringSubclases() {
        return this.getCarrera();
    }
}
