package objetosdos;

import java.time.LocalDateTime;

public interface FileComponent {

    String prettyPrint();
    String getNombre();
    String getExtension();
    String getTamanio();
    LocalDateTime getFechaCreacion();
    LocalDateTime getFechaModificacion();
    String getPermisos();
}
