Console.WriteLine("Ingrese dos palabras separadas por un espacio:");
string st = Console.ReadLine().Trim();

// Verifica que haya sólo un espacio entre las dos palabras.
while (st.Count(c => c == ' ') != 1) {
    Console.WriteLine("Ingrese dos palabras separadas por un espacio:");
    st = Console.ReadLine().Trim();
}

// Recorre las dos palabras buscando el falso.
int i = 0;
bool simetricas = true;
while (st[i] != ' ') {
    if (st[i] != st[st.Length-(++i)]) {
        simetricas = false;
        break;
    }
}
Console.WriteLine(simetricas);
Console.ReadKey();