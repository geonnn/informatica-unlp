package objetosdos;

import java.time.LocalDate;

public class CompraDolares extends ProductoFinanciero {
    private double valorCompra;

    public CompraDolares(LocalDate fechaOperacion, double valorCompra) {
        super(fechaOperacion);
        this.valorCompra = valorCompra;
    }

    @Override
    public double retornoInversion(double montoInicial) {
        return montoInicial;
    }
}
