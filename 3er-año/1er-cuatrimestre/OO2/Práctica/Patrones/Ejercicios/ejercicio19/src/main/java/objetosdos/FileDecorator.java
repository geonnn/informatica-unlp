package objetosdos;

import java.time.LocalDateTime;

public abstract class FileDecorator implements FileComponent {
    private FileComponent component;

    public FileDecorator(FileComponent component) {
        this.component = component;
    }


    @Override
    public String getNombre() {
        return this.component.getNombre();
    }

    @Override
    public String getExtension() {
        return this.component.getExtension();
    }

    @Override
    public String getTamanio() {
        return this.component.getTamanio();
    }

    @Override
    public LocalDateTime getFechaCreacion() {
        return this.component.getFechaCreacion();
    }

    @Override
    public LocalDateTime getFechaModificacion() {
        return this.component.getFechaModificacion();
    }

    @Override
    public String getPermisos() {
        return this.component.getPermisos();
    }

    @Override
    public String prettyPrint() {
        return this.component.prettyPrint();
    }

}
