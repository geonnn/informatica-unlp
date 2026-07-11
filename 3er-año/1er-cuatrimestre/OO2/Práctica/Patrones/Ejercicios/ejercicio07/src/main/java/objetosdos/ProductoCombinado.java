package objetosdos;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ProductoCombinado extends ProductoFinanciero {
    private List<ProductoFinanciero> productos;

    public ProductoCombinado(LocalDate fechaOperacion) {
        super(fechaOperacion);
        this.productos = new ArrayList<>();
    }

    public void addProductoFinanciero(ProductoFinanciero p) {
        if (!this.productos.contains(p))
            this.productos.add(p);
    }

    @Override
    public double retornoInversion(double montoInicial) {
        return this.productos.stream()
                .mapToDouble(p -> p.retornoInversion(montoInicial))
                .sum();
    }
}
