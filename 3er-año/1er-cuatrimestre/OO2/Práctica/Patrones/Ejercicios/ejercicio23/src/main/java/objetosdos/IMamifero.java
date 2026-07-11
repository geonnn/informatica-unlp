package objetosdos;

import java.time.LocalDate;

public interface IMamifero {
    String getIdentificador();
    String getEspecie();
    LocalDate getFechaNacimiento();
    IMamifero getPadre();
    IMamifero getMadre();
    IMamifero getAbueloMaterno();
    IMamifero getAbuelaMaterna();
    IMamifero getAbueloPaterno();
    IMamifero getAbuelaPaterna();
    void setIdentificador(String id);
    void setEspecie(String especie);
    void setFechaNacimiento(LocalDate fecha);
    void setPadre(IMamifero padre);
    void setMadre(IMamifero madre);
    boolean tieneComoAncestroA(IMamifero unMamifero);
}
