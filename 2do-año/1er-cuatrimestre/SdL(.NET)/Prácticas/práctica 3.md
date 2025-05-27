2) Implementar un método para imprimir por consola todos los elementos de una matriz (arreglo de dos dimensiones) pasada como parámetro. Debe imprimir todos los elementos de una fila en la misma línea en la consola.
```csharp
void ImprimirMatriz(double[,] matriz)
```

```csharp
void ImprimirMatriz(double[,] matriz) {
    for (int i = 0; i < matriz.GetLength(0); i++) {
        for (int j = 0; j < matriz.GetLength(1); j++)
            System.Console.Write(matriz[i,j] + " ");
        System.Console.WriteLine();
    }
}
```
---
3) Implementar el método ImprimirMatrizConFormato, similar al anterior pero ahora con un parámetro más que representa la plantilla de formato que debe aplicarse a los números al imprimirse. La plantilla de formato es un string de acuerdo a las convenciones de formato compuesto, por ejemplo “0.0” implica escribir los valores reales con un dígito para la parte decimal.
```csharp
void ImprimirMatrizConFormato(double[,] matriz, string formatString)
```

```csharp
void ImprimirMatrizConFormato(double[,] matriz, string formato) {
    for (int i = 0; i < matriz.GetLength(0); i++) {
        for (int j = 0; j < matriz.GetLength(1); j++)
            System.Console.Write(matriz[i,j].ToString(formato) + " ");
        System.Console.WriteLine();
    }
}
```
---
4) Implementar los métodos GetDiagonalPrincipal y GetDiagonalSecundaria que devuelven un vector con la diagonal correspondiente de la matriz pasada como parámetro. Si la matriz no es cuadrada generar una excepción ArgumentException.
```csharp
double[] GetDiagonalPrincipal(double[,] matriz)
double[] GetDiagonalSecundaria(double[,] matriz)
```

```csharp
bool EsCuadrada(double[,] matriz) => matriz.GetLength(0) == matriz.GetLength(1);

double[] GetDiagonalPrincipal(double[,] matriz) {
    if (!EsCuadrada(matriz))
        throw new ArgumentException();
    else {
        int length = matriz.GetLength(0);
        double[] vector = new double[length];
        for (int i = 0; i < length; i++)
            vector[i] = matriz[i,i];
        return vector;
    }
}
double[] GetDiagonalSecundaria(double[,] matriz) {
    if (!EsCuadrada(matriz))
        throw new ArgumentException();
    else {
        int length = matriz.GetLength(0);
        double[] vector = new double[length];
        for (int i = 0; i < length; i++)
            vector[i] = matriz[i, length-1-i];
        return vector;
    }
}
```
---
5) Implementar un método que devuelva un arreglo de arreglos con los mismos elementos que la matriz pasada como parámetro:
```csharp
double[][] GetArregloDeArreglo(double [,] matriz)
```

```csharp
double[][] GetArregloDeArreglo(double[,] matriz) {
    int f = matriz.GetLength(0);
    int c = matriz.GetLength(1);
    double[][] vector = new double[f][];
	for (int i = 0; i < f; i++) {
		vector[i] = new double[c];
		for (int j = 0; j < c; j++)
			vector[i][j] = matriz[i,j];
	}
    return vector;
}

double[,] matriz = new double[,] {
            {1, 2, 3, 4},
            {5, 6, 7, 8}
};

double[][] arrArr = GetArregloDeArreglo(matriz);
foreach (double[] dim in arrArr)
{
    foreach (double num in dim)
    {
        System.Console.WriteLine(num);
    }
}
```
---
6) Implementar los siguientes métodos que devuelvan la suma, resta y multiplicación de matrices pasadas como parámetros. Para el caso de la suma y la resta, las matrices deben ser del mismo tamaño, en caso de no serlo devolver null. Para el caso de la multiplicación la cantidad de columnas de A debe ser igual a la cantidad de filas de B, en caso contrario generar una excepción ArgumentException.
```csharp
double[,]? Suma(double[,] A, double[,] B)
double[,]? Resta(double[,] A, double[,] B)
double[,] Multiplicacion(double[,] A, double[,] B)
```

```csharp
double[,]? Suma(double[,] A, double[,] B) {
    if (A.GetLength(0) != B.GetLength(0) || A.GetLength(1) != B.GetLength(1))
        return null;
    // En este punto ya se sabe que las matrices tienen misma dimensión.
    else {
        int f = A.GetLength(0);
        int c = A.GetLength(1);
        double[,] matriz = new double[f,c];
        for (int i = 0; i < f; i++) {
            for(int j = 0; j < c; j++)
                matriz[i,j] = A[i,j] + B[i,j];
        }
        return matriz;
    }
}

double[,]? Resta(double[,] A, double[,] B) {
    if (A.GetLength(0) != B.GetLength(0) || A.GetLength(1) != B.GetLength(1))
        return null;
    // En este punto ya se sabe que las matrices tienen misma dimensión.
    else {
        int f = A.GetLength(0);
        int c = A.GetLength(1);
        double[,] matriz = new double[f,c];
        for (int i = 0; i < f; i++) {
            for(int j = 0; j < c; j++)
                matriz[i,j] = A[i,j] - B[i,j];
        }
        return matriz;
    }
}

double[,] Multiplicacion(double[,] A, double[,] B) {
    if (A.GetLength(1) != B.GetLength(0))
        throw new ArgumentException();
    // En este punto ya se sabe que columnas de A = filas de B.
    else {
        int fA = A.GetLength(0);
        int cA = A.GetLength(1);
        int fB = B.GetLength(0);
        int cB = B.GetLength(1);
        double[,] matriz = new double[fA,cB];

        // csharp inicializa automáticamente en 0.
        // for (int i = 0; i < fA; i++)
        //     for (int j = 0; j < cB; j++)
        //         matriz[i,j] = 0;

        for (int i = 0; i < fA; i++) {
            for (int j = 0; j < cB; j++)
            {
                for (int k = 0; k < fB; k++)
                    matriz[i,j] += A[i,k]*B[k,j];
            }
        }
    return matriz;
    }
}
```
---
7) ¿De qué tipo quedan definidas las variables x, y, z en el siguiente código?
```csharp
int i = 10;
var x = i * 1.0;
var y = 1f;
var z = i * y;
```
>x: double `int * double => double`
>y: single (float)
>z: single (float) `int * float => float`
---
8) Señalar errores de compilación y/o ejecución en el siguiente código
```csharp
object obj = new int[10];
dynamic dyna = 13;
Console.WriteLine(obj.Length); // error de compilación, obj no tiene definido Length.
Console.WriteLine(dyna.Length); // error de ejecución, int no tiene definido Lentgth.
```
---
9) ¿Qué líneas del siguiente método provocan error de compilación y por qué?
```csharp
var a = 3L;
dynamic b = 32;
object obj = 3;
a = a * 2.0; // Cannot implicitly convert type 'double' to 'long'.
b = b * 2.0;
b = "hola";
obj = b;
b = b + 11;
obj = obj + 11; // Operator '+' cannot be applied to operands of type 'object' and 'int'.
var c = new { Nombre = "Juan" };
var d = new { Nombre = "María" };
var e = new { Nombre = "Maria", Edad = 20 };
var f = new { Edad = 20, Nombre = "Maria" };
f.Edad = 22; // Property or indexer '<anonymous type: int Edad, string Nombre>.Edad' cannot be assigned to -- it is read only.
d = c;
e = d; // Cannot implicitly convert type '<anonymous type: string Nombre>' to '<anonymous type: string Nombre, int Edad>'.
f = e; // Cannot implicitly convert type '<anonymous type: string Nombre, int Edad>' to '<anonymous type: int Edad, string Nombre>'.
```
---
10) Verificar con un par de ejemplos si la sección opcional [:formatString] de formatos compuestos redondea o trunca cuando se formatean números reales restringiendo la cantidad de decimales. Plantear los ejemplos con cadenas de formato compuesto y con cadenas interpoladas.

---
11) Señalar errores de ejecución en el siguiente código
```csharp
List<int> a = [ 1, 2, 3, 4 ];
a.Remove(5);
a.RemoveAt(4); // Error out of range.
```
---
12) Realizar un análisis sintáctico para determinar si los paréntesis en una expresión aritmética están bien balanceados. Verificar que por cada paréntesis de apertura exista uno de cierre en la cadena de entrada. Utilizar una pila para resolverlo. Los paréntesis de apertura de la entrada se almacenan en una pila hasta encontrar uno de cierre, realizándose entonces la extracción del último paréntesis de apertura almacenado. Si durante el proceso se lee un paréntesis de cierre y la pila está vacía, entonces la cadena es incorrecta. Al finalizar el análisis, la pila debe quedar vacía para que la cadena leída sea aceptada, de lo contrario la misma no es válida.
```csharp
bool Parentesis(string expresion) {
    Stack<char> pila = new Stack<char>();
    foreach (char c in expresion) {
        if (c == '(')
            pila.Push('(');
        else if (c == ')') {
            if (pila.Count == 0)
                return false;
            pila.Pop();
        }
    }
    return pila.Count == 0;
}
```
---
13) Utilizar la clase Stack\<T> (pila) para implementar un programa que pase un número en base 10 a otra base realizando divisiones sucesivas. Por ejemplo para pasar 35 en base 10 a binario dividimos sucesivamente por dos hasta encontrar un cociente menor que el divisor, luego el resultado se obtiene leyendo de abajo hacia arriba el cociente de la última división seguida por todos los restos.
```csharp
using System.Text;

string ConvertirNumeroABase(int num, int baseN) {

    const string caracteres = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    if (baseN < 2 || baseN > caracteres.Length)
        throw new ArgumentException("Base no soportada.");

    Stack<char> pila = new Stack<char>();

    if (num == 0) return "0";

    while (num > 0) {
        pila.Push(caracteres[num%baseN]);
        num /= baseN;
    }
        
    StringBuilder r = new StringBuilder();
    while (pila.Count > 0)
        r.Append(pila.Pop());
    return r.ToString();
}
```
---
14) Utilizar la clase Queue\<T> para implementar un programa que realice el cifrado de un texto aplicando la técnica de clave repetitiva. La técnica de clave repetitiva consiste en desplazar un carácter una cantidad constante de acuerdo a la lista de valores que se encuentra en la clave. Por ejemplo: para la siguiente tabla de caracteres:

| A   | B   | C   | D   | E   | F   | G   | H   | I   | J   | K   | L   | M   | N   | Ñ   | O   | P   | Q   | R   | S   | T   | U   | V   | W   | X   | Y   | Z   | sp  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | 10  | 11  | 12  | 13  | 14  | 15  | 16  | 17  | 18  | 19  | 20  | 21  | 22  | 23  | 24  | 25  | 26  | 27  | 28  |

Si la clave es 5,3,9,7 y el mensaje a cifrar es “HOLA MUNDO”, se cifra de la siguiente manera:

| H     | O     | L     | A     | sp    | M     | U     | N     | D     | O     | <- Mensaje original      |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ------------------------ |
| 8     | 16    | 12    | 1     | 28    | 13    | 22    | 14    | 4     | 16    | **<- Código sin cifrar** |
| 5     | 3     | 9     | 7     | 5     | 3     | 9     | 7     | 5     | 3     | **<- Clave repetida**    |
| 13    | 19    | 21    | 8     | 5     | 16    | 3     | 21    | 9     | 19    | **<- Código cifrado**    |
| **M** | **R** | **T** | **H** | **E** | **O** | **C** | **T** | **I** | **R** | **<- Mensaje cifrado**   |

A cada carácter del mensaje original se le suma la cantidad indicada en la clave. En el caso que la suma fuese mayor que 28 se debe volver a contar desde el principio, Implementar una cola con los números de la clave encolados y a medida que se desencolen para utilizarlos en el cifrado, se vuelvan a encolar para su posterior utilización. Programar un método para cifrar y otro para descifrar.

```csharp
using System.Text;

const string caracteres = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ ";
Dictionary<char, int> mapaLetras = new Dictionary<char, int>();
for (int i = 0; i < caracteres.Length; i++)
    mapaLetras[caracteres[i]] = i + 1; // ej. primer bucle: mapaLetras['A'] = 0;

Dictionary<int, char> mapaNums = new Dictionary<int, char>();
for (int i = 0; i < caracteres.Length; i++)
    mapaNums[i + 1] = caracteres[i];

string MensajeCifrado(string mensaje, Queue<int> claveParam) {
    StringBuilder msjCifrado = new StringBuilder();
    int numLetra, numClave;

    Queue<int> clave = new Queue<int>(claveParam);

    foreach (char letra in mensaje)
    {
        numLetra = mapaLetras[letra];
        numClave = clave.Dequeue();
        clave.Enqueue(numClave);
        numLetra += numClave;
        if (numLetra > 28)
            numLetra -= 28;
        msjCifrado.Append(mapaNums[numLetra]);
    }
    
    return msjCifrado.ToString();
}

string DescifrarMensaje(string mensaje, Queue<int> claveParam) {
    StringBuilder msjCifrado = new StringBuilder();
    int numLetra, numClave;

    Queue<int> clave = new Queue<int>(claveParam);

    foreach (char letra in mensaje)
    {
        numLetra = mapaLetras[letra];
        numClave = clave.Dequeue();
        clave.Enqueue(numClave);
        numLetra -= numClave;
        if (numLetra < 1)
            numLetra += 28;
        msjCifrado.Append(mapaNums[numLetra]);
    }
    
    return msjCifrado.ToString();

}

System.Console.WriteLine("Ingrese mensaje a cifrar y una clave: ");

string? msj = Console.ReadLine().ToUpper();
if (msj == null)
    throw new ArgumentException("Mensaje no válido.");

int num;
System.Console.WriteLine("Ingrese números enteros para la clave (00 para cortar): ");
    Queue<int> colaClave = new Queue<int>();
    num = int.Parse(Console.ReadLine());
    while (num != 00) {
        colaClave.Enqueue(num);
        num = int.Parse(Console.ReadLine());
    }

System.Console.WriteLine("\nMensaje cifrado: \n");
System.Console.WriteLine(MensajeCifrado(msj, colaClave));

System.Console.WriteLine("\nMensaje descifrado: \n");
System.Console.WriteLine(DescifrarMensaje("MRTHEOCTIR", colaClave));
```
---
15) ¿Qué salida por la consola produce el siguiente código?

```csharp
int x = 0;
try
{
    Console.WriteLine((double)1.0 / x);
    Console.WriteLine(1 / x);
    Console.WriteLine("todo OK");
}
catch (Exception e)
{
    Console.WriteLine(e.Message);
}
```

```
∞
Exception thrown: 'System.DivideByZeroException' in teoria1.dll
Attempted to divide by zero.
```
---
16) Implementar un programa que permita al usuario ingresar números por la consola. Debe ingresarse un número por línea finalizado el proceso cuando el usuario ingresa una línea vacía. A medida que se van ingresando los valores el sistema debe mostrar por la consola la suma acumulada de los mismos. Utilizar double.Parse() y try/catch para validar que la entrada ingresada sea un número válido, en caso contrario advertir con un mensaje al usuario y proseguir con el ingreso de datos.

```csharp
void ProcesarNumero(ref double num, string input) {
    try
    {
        num += double.Parse(input);
    }
    catch (Exception e)
    {
        System.Console.WriteLine($"Número ingresado no válido, excepción: {e.Message}");
    }
    finally {
        System.Console.WriteLine($"Acumulado: {num}");
    }
}


double num = 0;
string? input;

System.Console.WriteLine("Ingrese un número a sumar");
input = Console.ReadLine();
ProcesarNumero(ref num, input);
while (input != "") {
    System.Console.WriteLine("Ingrese un número a sumar");
    input = Console.ReadLine();
    System.Console.WriteLine();
    ProcesarNumero(ref num, input);
}
```
---
17) Cuál es la salida por consola del siguiente programa:
```csharp
try
{
	Metodo1();
}
catch
{
	Console.WriteLine("Método 1 propagó una excepción no tratada");
}
try
{
	Metodo2();
}
catch
{
	Console.WriteLine("Método 2 propagó una excepción no tratada");
}
try
{
	Metodo3();
}
catch
{
	Console.WriteLine("Método 3 propagó una excepción");
}
void Metodo1()
{
	object obj = "hola";
	try
	{
		int i = (int)obj;
	}
	finally
	{
	Console.WriteLine("Bloque finally en Metodo1");
	}
}
void Metodo2()
{
	object obj = "hola";
	try
	{
		int i = (int)obj;
	}
	catch (OverflowException)
	{
		Console.WriteLine("Overflow");
	}
}
void Metodo3()
{
	object obj = "hola";
	try
	{
		int i = (int)obj;
	}
	catch (InvalidCastException)
	{
		Console.WriteLine("Excepción InvalidCast en Metodo3");
		throw;
	}
}
```

```
Bloque finally en Metodo1
Método 1 propagó una excepción no tratada
Método 2 propagó una excepción no tratada
Excepción InvalidCast en Metodo3
Método 3 propagó una excepción
```


