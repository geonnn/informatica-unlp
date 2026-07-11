package objetosdos;

import java.time.LocalDateTime;

public class FileOO2 implements FileComponent {
    private String nombre;
    private String extension;
    private String tamanio;
    private LocalDateTime fechaCreacion;
    private LocalDateTime fechaModificacion;
    private String permisos;

    public FileOO2(String nombre, String extension, String tamanio, LocalDateTime fechaCreacion, LocalDateTime fechaModificacion, String permisos) {
        this.nombre = nombre;
        this.extension = extension;
        this.tamanio = tamanio;
        this.fechaCreacion = fechaCreacion;
        this.fechaModificacion = fechaModificacion;
        this.permisos = permisos;
    }

    @Override
    public String getNombre() {
        return this.nombre;
    }

    @Override
    public String getExtension() {
        return this.extension;
    }

    @Override
    public String getTamanio() {
        return this.tamanio;
    }

    @Override
    public LocalDateTime getFechaCreacion() {
        return this.fechaCreacion;
    }

    @Override
    public LocalDateTime getFechaModificacion() {
        return this.fechaModificacion;
    }

    @Override
    public String getPermisos() {
        return this.permisos;
    }

    @Override
    public String prettyPrint() {
        return this.getNombre();
    }
}
