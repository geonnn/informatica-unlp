package objetosdos;

public class Atomo extends ElementoQuimico {
    String nombre;
    String simbolo;
    int peso;
    int carga;
    boolean metal;

    public Atomo(String nombre, String simbolo, int peso, int carga, boolean metal) {
        this.nombre = nombre;
        this.simbolo = simbolo;
        this.peso = peso;
        this.carga = carga;
        this.metal = metal;
    }

    @Override
    public String formula() {
        return this.simbolo;
    }

    @Override
    public int pesoMolecular() {
        return this.peso;
    }

    @Override
    public int carga() {
        return this.carga;
    }

    @Override
    public boolean esValida() {
        return true;
    }

    @Override
    public boolean esMetal() {
        return this.metal;
    }
}
