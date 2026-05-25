package objetosdos;

public class IntRing extends Ring {
    private int[] source;

    public IntRing(int[] src) {
        super();
        source = src;
    }

    public int next() {
        return source[nextIndex()];
    }

    @Override
    protected int getSourceLength() {
        return source.length;
    }
}