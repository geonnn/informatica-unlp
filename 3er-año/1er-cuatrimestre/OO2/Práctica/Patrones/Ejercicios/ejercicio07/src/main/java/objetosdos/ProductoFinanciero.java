package objetosdos;

import java.time.LocalDate;

public abstract class ProductoFinanciero {
    private LocalDate fechaOperacion;

    protected ProductoFinanciero(LocalDate fechaOperacion) {
        this.fechaOperacion = fechaOperacion;
    }

    public abstract double retornoInversion(double montoInicial);
}
