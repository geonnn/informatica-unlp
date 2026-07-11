package objetosdos;

public class MultiplicandoState extends OperandoState {

    public MultiplicandoState(Calculadora calculadora) {
        super(calculadora);
    }

    @Override
    public void setValor(double valor) {
        this.calculadora.setValorAcumulado(this.calculadora.getValorAcumulado() * valor);
        this.calculadora.setState(new InicialState(this.calculadora));
    }
}
