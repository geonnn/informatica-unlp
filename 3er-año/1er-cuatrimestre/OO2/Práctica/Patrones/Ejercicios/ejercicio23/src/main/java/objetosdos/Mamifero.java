package objetosdos;

import java.time.LocalDate;

public class Mamifero implements IMamifero {
    private String id;
    private String especie;
    private LocalDate fechaNacimiento;
    private IMamifero padre;
    private IMamifero madre;

    public Mamifero(String id, String especie, LocalDate fechaNacimiento) {
        this.id = id;
        this.especie = especie;
        this.fechaNacimiento = fechaNacimiento;
        this.padre = new MamiferoNull();
        this.madre = new MamiferoNull();
    }

    @Override
    public String getIdentificador() {
        return this.id;
    }

    @Override
    public String getEspecie() {
        return this.especie;
    }

    @Override
    public LocalDate getFechaNacimiento() {
        return this.fechaNacimiento;
    }

    @Override
    public IMamifero getPadre() {
        return this.padre;
    }

    @Override
    public IMamifero getMadre() {
        return this.madre;
    }

    @Override
    public IMamifero getAbueloMaterno() {
        return this.madre.getPadre();
    }

    @Override
    public IMamifero getAbuelaMaterna() {
        return this.madre.getMadre();
    }

    @Override
    public IMamifero getAbueloPaterno() {
        return this.padre.getPadre();
    }

    @Override
    public IMamifero getAbuelaPaterna() {
        return this.padre.getMadre();
    }

    @Override
    public void setIdentificador(String id) {
        this.id = id;
    }

    @Override
    public void setEspecie(String especie) {
        this.especie = especie;
    }

    @Override
    public void setFechaNacimiento(LocalDate fecha) {
        this.fechaNacimiento = fecha;
    }

    @Override
    public void setPadre(IMamifero padre) {
        this.padre = padre;
    }

    @Override
    public void setMadre(IMamifero madre) {
        this.madre = madre;
    }

    @Override
    public boolean tieneComoAncestroA(IMamifero unMamifero) {
        return (unMamifero == this.padre || unMamifero == this.madre)
                || this.padre.tieneComoAncestroA(unMamifero)
                || this.madre.tieneComoAncestroA(unMamifero);
    }
}
