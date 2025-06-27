#### a)
```pascal

    program ej1;
    const
        M = 4; // orden

    type

        recAlumno = record
            nombre: string[30];
            apellido: string[30];
            dni: int64;
            legajo: integer;
            anioIngreso: integer;
        end;

        // archivo de datos como arbol b:
        nodo = record
            cantDatos: integer;
            datos: array[1..M-1] of recAlumno;
            hijos: array[1..M] of integer;
        end;

        arbol = file of nodo;
        
        // archivo índice como arbol b:
        nodo = record
            cantClaves: integer;
            claves: array[1..M-1] of integer; // puede ser legajo como pk.
            enlaces: array[1..M-1] of integer; // al NRR.
            hijos: array[1..M] of integer; // nro de nodo.
        end;

        archivoDatos = file of recAlumno;
        arbol = file of nodo;

```
---

#### b)
$
    N = (M-1) \times A + M \times B + C
$

    N = tamaño del nodo en bytes.
    A = tamaño de un registro en bytes.
    B = tamaño de cada enlace a un hijo.
    C = tamaño que ocupa el campo referido a la cantidad de claves.

**Objetivo: obtener M, el órden del arbol.**

    Registro persona = 64 bytes. (A)
    Nodo del árbol B = 512 bytes. (N)
    Números enteros = 4 bytes. (B y C)

Entonces:

$
    N = (M-1) \times A + M \times B + C \\
    512 = (M-1) \times 64 + M \times 4 + 4 \\
    512 = 64M - 64 + 4M + 4 \\
    512 + 64 - 4 = 64M + 4M \\
    572 = 68M \\
    \frac{572}{68} = M \\
    7,33... = M \\
    \underline{7 = M}
$

---

#### c)

Si en vez de guardar los registros completos se guardaran sólo las claves y la posición (p. ej DNI y NRR) los registros (variable A en la fórmula) serían mucho más chicos, dando lugar a más claves por nodo.

Suponiendo:

    A = 8 bytes (dos enteros, DNI y NRR).
$
    N = (M-1) \times A + M \times B + C \\
    512 = (M-1) \times 8 + M \times 4 + 4 \\
    512 = 8M - 8 + 4M + 4 \\
    512 + 8 - 4 = 8M + 4M \\
    572 = 12M \\
    \frac{572}{12} = M \\
    47,66... = M \\
    \underline{47 = M}
$

El valor de M está inversamente relacionado con el tamaño de cada clave almacenada.
Cuanto más liviana la clave, mayor el orden, y por lo tanto menor altura del árbol B.
Esto se traduce en una reducción de accesos a disco (menos lecturas de nodos) en búsquedas, inserciones y eliminaciones.

---

#### d)

Como claves primarias para organizar el árbol B tanto el dni como el legajo son campos válidos.

---

#### e)