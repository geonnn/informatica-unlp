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
    // En este punto ya se sabe que las matrices tienen misma dimensión.
    else {
        int fA = A.GetLength(0);
        int cA = A.GetLength(1);
        int fB = B.GetLength(0);
        int cB = B.GetLength(1);
        double[,] matriz = new double[fA,cB];

        for (int i = 0; i < fA; i++)
            for (int j = 0; j < cB; j++)
                matriz[i,j] = 0;

        for (int i = 0; i < fA; i++) {
            for (int j = 0; j < cB; j++)
            {
                for (int r = 0; r < fB; r++)
                    matriz[i,j] += A[i,r]*B[r,j];
            }
        }
    return matriz;
    }
}

double[,] m1 = new double[,] {
            {1, 2, 3, 4},
            {5, 6, 7, 8}
};

double[,] m2 = new double[,] {
            {1, 2, 3, 4},
            {5, 6, 7, 8}
};

double[,] m3 = new double[,] {
            {1, 2, 3, 4},
            {5, 6, 7, 8},
            {9, 10, 11, 12}
};

double[,] mA = new double[,] {
            {3, 2, 1},
            {1, 1, 3},
            {0, 2, 1}
};

double[,] mB = new double[,] {
            {2, 1},
            {1, 0},
            {3, 2}
};

double[,] matriz = Multiplicacion(mA, mB);

foreach (double n in matriz)
{
    System.Console.WriteLine(n);
}