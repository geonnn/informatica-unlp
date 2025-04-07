using System.Text;
const string caracteres = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ ";
Dictionary<char, int> mapaLetras = new Dictionary<char, int>();
for (int i = 0; i < caracteres.Length; i++)
    mapaLetras[caracteres[i]] = i + 1; // ej. primer bucle: mapaLetras['A'] = 1;

string MensajeCifrado(string mensaje, string clave) {
    Queue<int> colaClave = new Queue<int>();


    Stack<char> pila = new Stack<char>();
        
    StringBuilder r = new StringBuilder();
    while (pila.Count > 0)
        r.Append(pila.Pop());
    return r.ToString();
}

System.Console.WriteLine("Ingrese mensaje a cifrar y una clave: ");

string? msj = Console.ReadLine();
string? clave = Console.ReadLine();

if (msj == null || clave == null)
    throw new ArgumentException("Mensaje o clave no válidos.");

System.Console.WriteLine("\nMensaje cifrado: \n");
System.Console.WriteLine(MensajeCifrado(msj, clave));