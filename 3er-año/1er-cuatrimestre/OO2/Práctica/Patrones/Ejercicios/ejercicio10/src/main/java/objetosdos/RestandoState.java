package objetosdos;

public class RestandoState extends OperandoState {

    public RestandoState(Calculadora calculadora) {
        super(calculadora);
    }

    @Override
    public void setValor(double valor) {
        this.calculadora.setValorAcumulado(this.calculadora.getValorAcumulado() - valor);
        this.calculadora.setState(new InicialState(this.calculadora));
    }
}
