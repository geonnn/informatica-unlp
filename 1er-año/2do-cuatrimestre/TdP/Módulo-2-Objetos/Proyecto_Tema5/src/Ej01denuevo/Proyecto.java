/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ej01denuevo;

/**
 *
 * @author Gonzalo
 */
public class Proyecto {
    private String nombre;
    private int codigo;
    private String nomDirector;
    private final int DFInv = 50;
    private int DLInv;
    private Investigador[] vecInvestigadores;

    public Proyecto(String nombre, int codigo, String nomDirector) {
        this.setNombre(nombre);
        this.setCodigo(codigo);
        this.setNomDirector(nomDirector);
        this.setDLInv(0);
        this.setVecInvestigadores();
    }

    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    private void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    private void setNomDirector(String nomDirector) {
        this.nomDirector = nomDirector;
    }

    private void setDLInv(int DLInv) {
        this.DLInv = DLInv;
    }

    private void setVecInvestigadores() {
        int dimF = this.getDFInv();
        this.vecInvestigadores = new Investigador[dimF];
        for (int i = 0; i < dimF; i++)
            this.vecInvestigadores[i] = null;
    }

    private String getNombre() {
        return this.nombre;
    }

    private int getCodigo() {
        return this.codigo;
    }

    private String getNomDirector() {
        return this.nomDirector;
    }
    
    private void setInvestigador(int i, Investigador unInvestigador) {
        this.getVecInvestigadores()[i] = unInvestigador;
    }

    private int getDFInv() {
        return this.DFInv;
    }

    private int getDLInv() {
        return this.DLInv;
    }

    private Investigador[] getVecInvestigadores() {
        return this.vecInvestigadores;
    }
    
    public void agregarInvestigador(Investigador unInvestigador) {
        if (unInvestigador == null)
            System.out.println("Ingrese un investigador válido.");
        else {
            int dimL = this.getDLInv();
            if (dimL < this.getDFInv()) {
                this.setInvestigador(dimL, unInvestigador);
                this.setDLInv(dimL + 1);
                System.out.println("Investigador " + unInvestigador.getNombre() + " incorporado al proyecto.");
            }
            else
                System.out.println("No pueden incorporarse más investigadores al proyecto.");
        }
    }
    
    public double dineroTotalOtorgado() {
        double aux = 0;
        Investigador investigador;
        for (int i = 0; i < this.getDLInv(); i++) {
            investigador = this.getVecInvestigadores()[i];
            aux += investigador.dineroTotalInvestigador();
        }
        return aux;
    }
    
    public void otorgarTodos(String nombre) {
        int i = 0;
        Investigador investigador = this.getVecInvestigadores()[i];
        while (i < this.getDLInv()&& !nombre.equals(investigador.getNombre())) {
            i++;
            investigador = this.getVecInvestigadores()[i];
        }
        if (investigador.getNombre().equals(nombre))
            investigador.otorgarTodos();
    }
    
    public String toString() {
        String aux = "";
        aux += "Nombre: " + this.getNombre() +
                "\nCódigo: " + this.getCodigo() +
                "\nDirector: " + this.getNomDirector() +
                "\nTotal de dinero otorgado: " + this.dineroTotalOtorgado();
        return aux;
    }
}
