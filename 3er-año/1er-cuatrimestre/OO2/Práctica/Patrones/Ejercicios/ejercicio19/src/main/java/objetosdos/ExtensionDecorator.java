package objetosdos;

public class ExtensionDecorator extends FileDecorator {

    public ExtensionDecorator(FileComponent component) {
        super(component);
    }

    @Override
    public String prettyPrint() {
        return super.prettyPrint() + " - " + this.getExtension();
    }
}
