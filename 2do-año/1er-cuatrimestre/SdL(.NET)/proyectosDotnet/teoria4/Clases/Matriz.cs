// -------------------- Matriz.cs -------------------- //

namespace Clases;

public class Matriz
{
    private int filas;
    private int columnas;
    private double[,] matriz;

    public Matriz(int filas, int columnas)
    {
        this.matriz = new double[filas, columnas];
        this.filas = filas;
        this.columnas = columnas;
    }

    public Matriz(double[,] matriz)
    {
        this.matriz = matriz;
    }

    public void SetElemento(int fila, int columna, double elemento)
    {
        try
        {
            this.matriz[fila,columna] = elemento;
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
        }
    }

    public double GetElemento(int fila, int columna)
    {
        try
        {
            return this.matriz[fila,columna];
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return 0;
        }
    }

    public void Imprimir()
    {
        for (int i = 0; i < filas; i++)
        {
            for (int j = 0; j < columnas; j++)
                Console.Write($"{matriz[i, j], 4} | ");
            Console.WriteLine();
        }
    }
    public void Imprimir(string formato)
    {
        for (int i = 0; i < filas; i++)
        {
            for (int j = 0; j < columnas; j++)
                Console.Write($"{matriz[i, j].ToString(formato), 7} | ");
            Console.WriteLine();
        }
    }

    public double[] GetFila(int fila)
    {
        try
        {
            double[] vector = new double[columnas];
            for (int i = 0; i < columnas; i++)
                vector[i] = matriz[fila,i];
            return vector;
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return new double[0];
        }
    }

    public double[] GetColumna(int columna)
    {
        try
        {
            double[] vector = new double[filas];
            for (int i = 0; i < filas; i++)
                vector[i] = matriz[i,columna];
            return vector;
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return new double[0];
        }
    }

    private bool EsCuadrada(double[,] matriz) => filas == columnas;

    public double[] GetDiagonalPrincipal(double[,] matriz)
    {
        if (!EsCuadrada(matriz))
            throw new ArgumentException();
        else
        {
            double[] vector = new double[filas];
            for (int i = 0; i < filas; i++)
                vector[i] = matriz[i, i];
            return vector;
        }
    }

    public double[] GetDiagonalSecundaria(double[,] matriz)
    {
        if (!EsCuadrada(matriz))
            throw new ArgumentException();
        else
        {
            double[] vector = new double[filas];
            for (int i = 0; i < filas; i++)
                vector[i] = matriz[i, filas - 1 - i];
            return vector;
        }
    }

    public double[][] GetArregloDeArreglo()
    {
        double[][] arrDeArr = new double[filas][];
        for (int i = 0; i < filas; i++) {
            arrDeArr[i] = new double[columnas];
            for (int j = 0; j < columnas; j++)
                arrDeArr[i][j] = matriz[i,j];
        }
        return arrDeArr;
    }

    public void Sumarle(Matriz m)
    {
        for (int i = 0; i < filas; i++)
            for (int j = 0; j < columnas; j++)
                this.matriz[i,j] += m.GetElemento(i,j);
    }

    public void Restarle(Matriz m)
    {
        for (int i = 0; i < filas; i++)
            for (int j = 0; j < columnas; j++)
                this.matriz[i,j] -= m.GetElemento(i,j);
    }
}