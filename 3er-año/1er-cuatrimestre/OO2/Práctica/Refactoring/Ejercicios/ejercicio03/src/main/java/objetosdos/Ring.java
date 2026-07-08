package objetosdos;

public abstract class Ring {
    protected int idx;

    protected Ring() {
        idx = 0;
    }

    protected abstract int getSourceLength();

    protected int nextIndex() {
        if (idx >= getSourceLength())
            idx = 0;
        return idx++;
    }
}
