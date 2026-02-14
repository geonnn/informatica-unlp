using teoria8;

// ----- Program.cs -----
int[] vector = [1, 2, 3, 4, 5];
vector.Print("Valores iniciales: ");
vector.Donde(n => n % 2 == 0).Print("Pares: ");
vector.Donde(n => n % 2 == 1).Seleccionar(n => n * n).Print("Impares al cuadrado: ");

delegate int FuncionEntera(int n);
delegate bool Predicado (int n);