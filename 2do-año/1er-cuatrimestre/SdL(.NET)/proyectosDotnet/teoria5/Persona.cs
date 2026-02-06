public class Persona
{
    private const int _idxNombre = 0;
    private const int _idxSexo = 1;
    private const int _idxDni = 2;
    private const int _idxFechaNacimiento = 3;
    private const int _idxEdad = 4;

    public string Nombre { get; set; }
    public char Sexo { get; set; }
    public int Dni { get; set; }
    public DateTime FechaNacimiento { get; set; }

    public int Edad
    {
        get
        {
            DateTime today = DateTime.Today;
            int edad = today.Year - this.FechaNacimiento.Year;
            if (this.FechaNacimiento.DayOfYear > today.DayOfYear)
                edad -= 1;
            return edad;
        }
    }

    public object this[int i]
    {
        get => i switch
        {
            _idxNombre => Nombre,
            _idxSexo => Sexo,
            _idxDni => Dni,
            _idxFechaNacimiento => FechaNacimiento,
            _idxEdad => Edad,
            _ => throw new IndexOutOfRangeException($"El índice {i} no es válido para Persona.")
        };

        set
        {
            switch (i)
            {
                case _idxNombre:
                    if (value is string s) Nombre = s;
                    else throw new ArgumentException("El índice 0 (Nombre) espera un string.");
                    break;

                case _idxSexo:
                    if (value is char c) Sexo = c;
                    else if (value is string str && str.Length == 1) Sexo = str[0];
                    else throw new ArgumentException("El índice 1 (Sexo) espera un char.");
                    break;

                case _idxDni:
                    if (value is int dni) Dni = dni;
                    else throw new ArgumentException("El índice 2 (DNI) espera un entero.");
                    break;

                case _idxFechaNacimiento:
                    if (value is DateTime fecha) FechaNacimiento = fecha;
                    else throw new ArgumentException("El índice 3 (Fecha) espera un DateTime.");
                    break;

                case _idxEdad:
                    throw new InvalidOperationException("La propiedad Edad es calculada y de solo lectura.");
                default:
                    throw new IndexOutOfRangeException($"El índice {i} no es válido para Persona.");
            }
        }
    }
}