package objetosdos;

import java.time.LocalDate;

public class CompraPesos extends ProductoFinanciero {
    private double valorCompra;

    public CompraPesos(LocalDate fechaOperacion, double valorCompra) {
        super(fechaOperacion);
        this.valorCompra = valorCompra;
    }

    @Override
    public double retornoInversion(double montoInicial) {
        return montoInicial;
    }
}
