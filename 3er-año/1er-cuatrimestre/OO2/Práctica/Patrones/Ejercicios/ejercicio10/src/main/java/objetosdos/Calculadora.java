package objetosdos;

public class Calculadora {
    private CalculadoraState state;
    private double valorAcumulado;

    public Calculadora() {
        this.valorAcumulado = 0;
        this.setState(new InicialState(this));
    }

    public void setState(CalculadoraState state) {
        this.state = state;
    }

    /**
     * Devuelve el resultado actual de la operación realizada.
     * Si no se ha realizado ninguna operación, devuelve el valor acumulado.
     * Si la calculadora se encuentra en error, devuelve “error”
     */
    public String getResultado() {
        return this.state.getResultado();
    }

    /**
     * Pone en cero el valor acumulado y reinicia la calculadora
     */
    public void borrar() {
        this.valorAcumulado = 0;
        this.setState(new InicialState(this));
    }

    /**
     * Asigna un valor para operar.
     * si hay una operación en curso, el valor será utilizado en la operación
     */
    public void setValor(double unValor) {
        this.state.setValor(unValor);
    }

    public void setValorAcumulado(double valor) {
        this.valorAcumulado = valor;
    }

    public double getValorAcumulado() {
        return this.valorAcumulado;
    }

    /**
     * Indica que la calculadora debe esperar un nuevo valor.
     * Si a continuación se le envía el mensaje setValor(), la calculadora sumará
     * el valor recibido como parámetro, al valor actual y guardará el resultado
     */
    public void mas() {
        this.state.mas();
    }

    public void menos() {
        this.state.menos();
    }

    public void por() {
        this.state.por();
    }

    public void dividido() {
        this.state.dividido();
    }
}
