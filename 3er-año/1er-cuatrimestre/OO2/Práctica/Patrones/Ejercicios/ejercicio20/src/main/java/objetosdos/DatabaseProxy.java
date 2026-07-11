package objetosdos;

import java.util.Collection;
import java.util.List;

public class DatabaseProxy implements DatabaseAccess {
    DatabaseRealAccess db;
    Usuario user;

    public DatabaseProxy(DatabaseRealAccess db, Usuario u) {
        this.db = db;
        this.user = u;
    }

    @Override
    public int insertNewRow(List<String> rowData) {
        if (user.isLogged())
            return this.db.insertNewRow(rowData);
        else
            throw new RuntimeException("Para acceder a la bd debe estar logeado.");
    }

    @Override
    public Collection<String> getSearchResults(String queryString) {
        if (user.isLogged())
            return this.db.getSearchResults(queryString);
        else
            throw new RuntimeException("Para acceder a la bd debe estar logeado.");
    }
}
