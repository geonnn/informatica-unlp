package objetosdos;

public class DividiendoState extends OperandoState {

    public DividiendoState(Calculadora calculadora) {
        super(calculadora);
    }

    @Override
    public void setValor(double valor) {
        if (valor == 0)
            this.calculadora.setState(new ErrorState(this.calculadora));
        else {
            this.calculadora.setValorAcumulado(this.calculadora.getValorAcumulado() / valor);
            this.calculadora.setState(new InicialState(this.calculadora));
        }
    }
}
