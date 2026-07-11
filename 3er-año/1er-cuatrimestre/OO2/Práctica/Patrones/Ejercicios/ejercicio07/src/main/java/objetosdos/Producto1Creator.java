package objetosdos;

import java.time.LocalDate;

public class Producto1Creator implements Creator {

    @Override
    public ProductoFinanciero factoryMethod() {
        LocalDate today = LocalDate.now();
        ProductoCombinado p = new ProductoCombinado(today);
        p.addProductoFinanciero(new CompraDolares(today, 1000));
        p.addProductoFinanciero(new PlazoFijo(today, 30, 0.3));
        p.addProductoFinanciero(new CompraPesos(today, 5000));
        return p;
    }

}
