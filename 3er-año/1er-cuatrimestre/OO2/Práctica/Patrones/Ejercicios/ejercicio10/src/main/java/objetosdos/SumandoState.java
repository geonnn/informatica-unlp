package objetosdos;

public class SumandoState extends OperandoState {

    public SumandoState(Calculadora calculadora) {
        super(calculadora);
    }

    @Override
    public void setValor(double valor) {
        this.calculadora.setValorAcumulado(this.calculadora.getValorAcumulado() + valor);
        this.calculadora.setState(new InicialState(this.calculadora));
    }
}
