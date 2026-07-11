package objetosdos;

public class TamanioDecorator extends FileDecorator {

    public TamanioDecorator(FileComponent component) {
        super(component);
    }

    @Override
    public String prettyPrint() {
        return super.prettyPrint() + " - " + this.getTamanio();
    }
}
