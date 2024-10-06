/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema3;

/**
 *
 * @author gonza
 */
public class Autor {
    private String nombre;
    private String biografia;
    private String origen;
    
    public Autor(String unNombre, String unaBiografia, String unOrigen) {
        setNombre(unNombre);
        setBiografia(unaBiografia);
        setOrigen(unOrigen);
    }

    private void setNombre(String unNombre) {
        this.nombre = unNombre;
    }

    private void setBiografia(String unaBiografia) {
        this.biografia = unaBiografia;
    }

    private void setOrigen(String unOrigen) {
        this.origen = unOrigen;
    }

    public String getNombre() {
        return nombre;
    }

    public String getBiografia() {
        return biografia;
    }

    public String getOrigen() {
        return origen;
    }
    
    public String toString() {
        String aux;
        aux = getNombre() + " | biografía: " + getBiografia() + " | origen: " + getOrigen() + ".";
        return aux;
    }
    
}
