package objetosdos;

public class CharRing extends Ring {
    private char[] source;

    public CharRing(String src) {
        super();
        source = src.toCharArray();
    }

    public char next() {
        return source[nextIndex()];
    }

    @Override
    protected int getSourceLength() {
        return source.length;
    }
}
