package objetosdos;

public abstract class CalculadoraState {
    protected Calculadora calculadora;

    protected CalculadoraState(Calculadora calculadora) {
        this.calculadora = calculadora;
    }

    public abstract String getResultado();
    public abstract void setValor(double valor);
    public abstract void mas();
    public abstract void menos();
    public abstract void por();
    public abstract void dividido();
}