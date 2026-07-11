package objetosdos;

public class InicialState extends CalculadoraState {

    public InicialState(Calculadora calculadora) {
        super(calculadora);
    }

    @Override
    public String getResultado() {
        return String.valueOf(this.calculadora.getValorAcumulado());
    }

    @Override
    public void setValor(double valor) {
        this.calculadora.setValorAcumulado(valor);
    }

    @Override
    public void mas() {
        this.calculadora.setState(new SumandoState(this.calculadora));
    }

    @Override
    public void menos() {
        this.calculadora.setState(new RestandoState(this.calculadora));
    }

    @Override
    public void por() {
        this.calculadora.setState(new MultiplicandoState(this.calculadora));
    }

    @Override
    public void dividido() {
        this.calculadora.setState(new DividiendoState(this.calculadora));
    }

}
