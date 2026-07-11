package objetosdos;

import java.time.LocalDate;

public class PlazoFijo extends ProductoFinanciero {
    private int cantidadDias;
    private double interes;

    public PlazoFijo(LocalDate fechaOperacion, int cantidadDias, double interes) {
        super(fechaOperacion);
        this.cantidadDias = cantidadDias;
        this.interes = interes;
    }

    @Override
    public double retornoInversion(double montoInicial) {
        return 0;
    }
}
