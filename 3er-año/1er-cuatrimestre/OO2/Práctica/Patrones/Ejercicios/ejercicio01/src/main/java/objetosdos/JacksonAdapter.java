package objetosdos;

import java.util.List;

// Para implementar Jackson habría que agregar este otro adapter.
public class JacksonAdapter implements Exporter {

    @Override
    public String exportar(List<Socio> socios) {
        // a implementar
        return "";
    }
}
