package objetosdos;

public abstract class OperandoState extends CalculadoraState {

    protected OperandoState(Calculadora calculadora) {
        super(calculadora);
    }

    @Override
    public String getResultado() {
        return String.valueOf(this.calculadora.getValorAcumulado());
    }

    @Override
    public void mas() {
        this.calculadora.setState(new ErrorState(this.calculadora));
    }

    @Override
    public void menos() {
        this.calculadora.setState(new ErrorState(this.calculadora));
    }

    @Override
    public void por() {
        this.calculadora.setState(new ErrorState(this.calculadora));
    }

    @Override
    public void dividido() {
        this.calculadora.setState(new ErrorState(this.calculadora));
    }
}
