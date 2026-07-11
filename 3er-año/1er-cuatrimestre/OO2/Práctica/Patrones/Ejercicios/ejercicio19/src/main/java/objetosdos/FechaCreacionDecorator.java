package objetosdos;

public class FechaCreacionDecorator extends FileDecorator {

    public FechaCreacionDecorator(FileComponent component) {
        super(component);
    }

    @Override
    public String prettyPrint() {
        return super.prettyPrint() + " - " + this.getFechaCreacion().toString();
    }
}
