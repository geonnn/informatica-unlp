/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema3;

/**
 *
 * @author gonza
 */
public class Estante {
    private int MAX_LIBROS;
    private Libro[] vecLibros = new Libro[MAX_LIBROS];
    private int dimL;
    
    // Si se especifica el máximo se crea con ese máximo.
    public Estante(int maxLibros) {
        setDimL(0);
        setMAX_LIBROS(maxLibros);
    }
    
    // Si no se especifica se crea un estante con capacidad máxima 20.
    public Estante() {
        setDimL(0);
        setMAX_LIBROS(20);
    }
    
    public boolean estaLleno() {
        return(this.dimL == this.MAX_LIBROS);
    }
    
    public void agregarLibro(Libro unLibro) {
        if (this.estaLleno())
            System.out.println("No se puede agregar el libro, el estante está lleno.");
        else {
            this.vecLibros[this.dimL] = unLibro;
            this.dimL++;
            System.out.println("Libro agregado al estante.");
        }
    }
    
    public Libro buscarLibro(String tituloInput) {
        int i = 0;
        while (i < this.dimL) {
            if (this.vecLibros[i].getTitulo().equals(tituloInput))
                return this.vecLibros[i];
            i++;
        }
        System.out.println("No se encontró el libro con el título ingresado");
        return null;
    }

    private void setDimL(int unaDimL) {
        this.dimL = unaDimL;
    }

    private void setMAX_LIBROS(int unMaxLibros) {
        this.MAX_LIBROS = unMaxLibros;
    }
    
    
}