/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ej01;

/**
 *
 * @author Gonzalo
 */
public class Proyecto {
    private String nombre;
    private int codigo;
    private String nomDirector;
    private ArrayInvestigadores vecInvestigadores;
    
    
    // Constructor.
    public Proyecto(String nombre, int codigo, String nomDirector) {
        this.setNombre(nombre);
        this.setCodigo(codigo);
        this.setNomDirector(nomDirector);
        this.setVecInvestigadores(50); // Máximo 50 investigadores.
    }
    
    // Setters.
    private void setNombre(String nombre) {
        this.nombre = nombre;
    }

    private void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    private void setNomDirector(String nomDirector) {
        this.nomDirector = nomDirector;
    }
    
    private void setVecInvestigadores(int DF) {
        this.vecInvestigadores = new ArrayInvestigadores(DF);
    }
    
    // Getters.
    private String getNombre() {
        return this.nombre;
    }

    private int getCodigo() {
        return this.codigo;
    }

    private String getNomDirector() {
        return this.nomDirector;
    }
    
    private ArrayInvestigadores getVecInvestigadores() {
        return this.vecInvestigadores;
    }
    
    // Otros métodos.
    public void agregarInvestigador(Investigador unInvestigador) {
        if (this.vecInvestigadores.agregarInvestigador(unInvestigador))
            System.out.println("Investigador " + unInvestigador.getNombre()+ " incorporado al proyecto.");
        else
            System.out.println("El proyecto ya tiene la cantidad máxima de investigadores.");
    }
}
