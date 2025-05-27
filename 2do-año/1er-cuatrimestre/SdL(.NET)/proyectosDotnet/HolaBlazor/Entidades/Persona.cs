namespace HolaBlazor.Entidades;

class Persona
{
    public string Nombre { get; set; } = "";
    public string Apellido { get; set; } = "";
    public int? Edad { get; set; } //podría faltar el dato de la edad
    public Persona() { }

    public Persona(string nombre, string apellido, int? edad = null)
    {
        Nombre = nombre;
        Apellido = apellido;
        Edad = edad;
    }
    // vamos a hardcodear una lista de personas
    // que usaremos en los siguientes ejemplos
    // para ello definimos el siguiente método estático
    public static List<Persona> GetLista()
    {
        return new List<Persona>() {
           new Persona() {Nombre="Pablo",Apellido="Perez", Edad=34},
           new Persona() {Nombre="Laura",Apellido="García", Edad=30},
           new Persona() {Nombre="José",Apellido="Lopez", Edad=45},
           new Persona() {Nombre="Ana",Apellido="Colombo", Edad=21},
           new Persona() {Nombre="María",Apellido="Suarez", Edad=15},
       };
    }
}
