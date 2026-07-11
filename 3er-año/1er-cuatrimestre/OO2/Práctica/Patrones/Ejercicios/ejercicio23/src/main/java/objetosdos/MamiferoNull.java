package objetosdos;

import java.time.LocalDate;

public class MamiferoNull implements IMamifero {
    @Override
    public String getIdentificador() {
        return "desconocido";
    }

    @Override
    public String getEspecie() {
        return "desconocido";
    }

    @Override
    public LocalDate getFechaNacimiento() {
        // fecha dummy para no retornar null:
        return LocalDate.MIN;
    }

    @Override
    public IMamifero getPadre() {
        return this;
    }

    @Override
    public IMamifero getMadre() {
        return this;
    }

    @Override
    public IMamifero getAbueloMaterno() {
        return this;
    }

    @Override
    public IMamifero getAbuelaMaterna() {
        return this;
    }

    @Override
    public IMamifero getAbueloPaterno() {
        return this;
    }

    @Override
    public IMamifero getAbuelaPaterna() {
        return this;
    }

    @Override
    public void setIdentificador(String id) {

    }

    @Override
    public void setEspecie(String especie) {

    }

    @Override
    public void setFechaNacimiento(LocalDate fecha) {

    }

    @Override
    public void setPadre(IMamifero padre) {

    }

    @Override
    public void setMadre(IMamifero madre) {

    }

    @Override
    public boolean tieneComoAncestroA(IMamifero unMamifero) {
        return false;
    }
}
