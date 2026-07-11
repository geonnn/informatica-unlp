package objetosdos;

import java.time.LocalDate;

public class CompraBonoAltoRiesgo extends ProductoFinanciero {
    private int parking;

    public CompraBonoAltoRiesgo(LocalDate fechaOperacion, int parking) {
        super(fechaOperacion);
        this.parking = parking;
    }

    @Override
    public double retornoInversion(double montoInicial) {
        return montoInicial * 1.5; // variación random.
    }
}
