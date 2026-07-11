package objetosdos;

import java.time.LocalDate;

public class CompraBonoBajoRiesgo extends ProductoFinanciero {
    private int parking;

    public CompraBonoBajoRiesgo(LocalDate fechaOperacion, int parking) {
        super(fechaOperacion);
        this.parking = parking;
    }

    @Override
    public double retornoInversion(double montoInicial) {
        return montoInicial * 1.05; // variación random.
    }
}
