/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ej01denuevo;

/**
 *
 * @author Gonzalo
 */
public class Investigador {
    private String nombre;
    private int categoria;
    private String especialidad;
    private final int DFSubs = 5;
    private int DLSubs;
    private Subsidio[] vecSubsidios;

    public Investigador(String nombre, int categoria, String especialidad) {
        if (setCategoria(categoria)) {
            this.setNombre(nombre);
            this.setEspecialidad(especialidad);
            this.setDLSubs(0);
            this.setVecSubsidios();
        }
        else {
            System.out.println("Ingrese una categoría válida (1 a 5)");
        }
    }
    
    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    private boolean setCategoria(int categoria) {
        if (categoria >= 1 && categoria <= 5) {
            this.categoria = categoria;
            return true;
        }
        else
            return false;
    }

    private void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }
    
    private void setDLSubs(int DLSubs) {
        this.DLSubs = DLSubs;
    }
    
    private void setVecSubsidios() {
        int dimF = this.getDFSubs();
        this.vecSubsidios = new Subsidio[dimF];
        for (int i = 0; i < dimF; i++)
            this.vecSubsidios[i] = null;
    }
    
    private void setSubsidio(int i, Subsidio unSubsidio) {
        this.getVecSubsidios()[i] = unSubsidio;
    }

    public String getNombre() {
        return this.nombre;
    }

    private int getCategoria() {
        return this.categoria;
    }

    private String getEspecialidad() {
        return this.especialidad;
    }

    private int getDFSubs() {
        return this.DFSubs;
    }

    private int getDLSubs() {
        return this.DLSubs;
    }

    private Subsidio[] getVecSubsidios() {
        return this.vecSubsidios;
    }
    
    public void agregarSubsidio(Subsidio unSubsidio) {
        int dimL = this.getDLSubs();
        if (dimL < this.getDFSubs()) {
            this.setSubsidio(dimL, unSubsidio);
            this.setDLSubs(dimL + 1);
            System.out.println("Subsidio motivo" + unSubsidio.getMotivo() + " agregado al investigador " + this.getNombre() + ".");
        }
        else
            System.out.println("El investigador " + this.getNombre() + " no puede incorporar más subsidios.");
    }
    
    public double dineroTotalInvestigador() {
        double aux = 0;
        Subsidio subsidio;
        for (int i = 0; i < this.getDLSubs(); i++) {
            subsidio = this.getVecSubsidios()[i];
            if (subsidio.isOtorgado())
                aux += subsidio.getMonto();
        }
        return aux;
    }
    
    public void otorgarTodos() {
        Subsidio subsidio;
        for (int i = 0; i < this.getDLSubs(); i++) {
            subsidio = this.getVecSubsidios()[i];
            if (!subsidio.isOtorgado())
                subsidio.setOtorgado(true);
            }
    }
    
}
