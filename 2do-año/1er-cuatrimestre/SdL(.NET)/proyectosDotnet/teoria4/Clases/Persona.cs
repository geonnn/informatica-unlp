// -------------------- Persona.cs -------------------- //

namespace Clases;

public class Persona
{
    private string Nombre {get; set;}
    private int Edad {get; set;}
    private int DNI {get; set;}

    public Persona(string nom, int edad, int dni)
    {
        this.Nombre = nom;
        this.Edad = edad;
        this.DNI = dni;
    }

    public bool EsMayorQue(Persona p)
    {
        return this.Edad > p.Edad;
    }

    public override string ToString()
    {
        return $"Nombre: {Nombre}, Edad: {Edad}, DNI: {DNI}";
    }

}
