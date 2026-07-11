package objetosdos;

public class PermisosDecorator extends FileDecorator {

    public PermisosDecorator(FileComponent component) {
        super(component);
    }

    @Override
    public String prettyPrint() {
        return super.prettyPrint() + " - " + this.getPermisos();
    }
}
