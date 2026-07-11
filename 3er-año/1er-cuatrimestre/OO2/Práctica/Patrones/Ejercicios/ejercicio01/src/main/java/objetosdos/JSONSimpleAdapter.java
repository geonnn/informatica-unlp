package objetosdos;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.util.List;

// ADAPTER
public class JSONSimpleAdapter implements Exporter {

    @Override
    public String exportar(List<Socio> socios) {

        // ADAPTEE
        JSONArray jsonArray = new JSONArray();

        for (Socio s : socios) {
            // ADAPTEE
            JSONObject jsonObject = new JSONObject();

            jsonObject.put("nombre", s.getNombre());
            jsonObject.put("email", s.getEmail());
            jsonObject.put("legajo", s.getLegajo());

            jsonArray.add(jsonObject);
        }

        JSONParser jsonParser = new JSONParser();
        return jsonArray.toJSONString();
    }
}
