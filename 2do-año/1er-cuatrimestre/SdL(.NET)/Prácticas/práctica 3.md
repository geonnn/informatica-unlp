2) Implementar un método para imprimir por consola todos los elementos de una matriz (arreglo de dos dimensiones) pasada como parámetro. Debe imprimir todos los elementos de una fila en la misma línea en la consola.
```C#
void ImprimirMatriz(double[,] matriz)
```
3) Implementar el método ImprimirMatrizConFormato, similar al anterior pero ahora con un parámetro más que representa la plantilla de formato que debe aplicarse a los números al imprimirse. La plantilla de formato es un string de acuerdo a las convenciones de formato compuesto, por ejemplo “0.0” implica escribir los valores reales con un dígito para la parte decimal.
```C#
void ImprimirMatrizConFormato(double[,] matriz, string formatString)
```
4) Implementar los métodos GetDiagonalPrincipal y GetDiagonalSecundaria que devuelven un vector con la diagonal correspondiente de la matriz pasada como parámetro. Si la matriz no es cuadrada generar una excepción ArgumentException.
```C#
double[] GetDiagonalPrincipal(double[,] matriz)
double[] GetDiagonalSecundaria(double[,] matriz)
```
5) Implementar un método que devuelva un arreglo de arreglos con los mismos elementos que la matriz pasada como parámetro:
```C#
double[][] GetArregloDeArreglo(double [,] matriz)
```

```C#
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
```C#
double[,]? Suma(double[,] A, double[,] B)
double[,]? Resta(double[,] A, double[,] B)
double[,] Multiplicacion(double[,] A, double[,] B)
```
