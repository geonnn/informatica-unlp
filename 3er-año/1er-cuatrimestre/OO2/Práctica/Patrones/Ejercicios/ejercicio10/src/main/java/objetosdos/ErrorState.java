package objetosdos;

public class ErrorState extends CalculadoraState {

    public ErrorState(Calculadora calculadora) {
        super(calculadora);
    }

    @Override
    public String getResultado() {
        return "Error";
    }

    @Override
    public void setValor(double valor) {

    }

    @Override
    public void mas() {

    }

    @Override
    public void menos() {

    }

    @Override
    public void por() {

    }

    @Override
    public void dividido() {

    }
}
