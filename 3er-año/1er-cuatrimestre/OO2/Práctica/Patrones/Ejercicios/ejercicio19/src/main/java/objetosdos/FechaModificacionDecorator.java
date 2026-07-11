package objetosdos;

public class FechaModificacionDecorator extends FileDecorator {

    public FechaModificacionDecorator(FileComponent component) {
        super(component);
    }

    @Override
    public String prettyPrint() {
        return super.prettyPrint() + " - " + this.getFechaModificacion().toString();
    }
}
