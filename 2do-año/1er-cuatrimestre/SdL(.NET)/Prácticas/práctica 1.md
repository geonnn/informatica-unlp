1) Consultar en la documentación de Microsoft y responder cuál es la diferencia entre los métodos WriteLine() y Write() de la clase System.Console ¿Cómo funciona el método ReadKey() de la misma clase? Escribir un programa que imprima en la consola la frase “Hola Mundo” haciendo una pausa entre palabra y palabra esperando a que el usuario presione una tecla para continuar.
Tip: usar los métodos ReadKey() y Write() de la clase System.Console

```C#
Console.Write("Hola");
Console.ReadKey(true); // no muestra la tecla que se presiona.
Console.Write(" Mundo");
Console.ReadKey(false); // muestra la tecla presionada.
```
---
2) Investigar por las secuencias de escape \n, \t , \" y \\. Escribir un programa que las utilice para imprimir distintos mensajes en la consola.

```C#
Console.WriteLine("Hola\nMundo"); // Hola
								 // Mundo
Console.WriteLine("Hola\tMundo"); // Hola    Mundo
Console.WriteLine("Hola\"Mundo"); // Hola"Mundo
Console.WriteLine("Hola\\Mundo"); // Hola\Mundo
```
---
3) El carácter @ delante de un string desactiva los códigos de escape. Probar el siguiente fragmento de código, eliminar el carácter @ y utilizar las secuencias de escape necesarias para que el programa siga funcionando de igual manera.
```C#
string st = @"c:\windows\system";
Console.WriteLine(st);
```
```C#
string st = "c:\\windows\\system";
Console.WriteLine(st);
```
---
4) Escribir un programa que solicite al usuario ingresar su nombre e imprima en la consola un saludo personalizado utilizando ese nombre o la frase “Hola mundo” si el usuario ingresó una línea en blanco.
Para ingresar un string desde el teclado utilizar Console.ReadLine()
```C#
Console.WriteLine("Ingrese su nombre:");
string nombre = Console.ReadLine();
string st = (nombre != "") ? $"Hola {nombre}" : "Hola mundo";
Console.WriteLine(st);
```
---
5) Idem. al ejercicio anterior salvo que se imprimirá un mensaje de saludo diferente según sea el
nombre ingresado por el usuario. Así para “Juan” debe imprimir “¡Hola amigo!”, para “María” debe imprimir “Buen día señora”, para “Alberto” debe imprimir “Hola Alberto”. En otro caso, debe imprimir “Buen día ” seguido del nombre ingresado o “¡Buen día mundo!” si se ha ingresado una línea vacía.
a) utilizando if ... else if
b) utilizando switch

If ... else if:
```C#
Console.WriteLine("Ingrese su nombre:");
string nombre = Console.ReadLine();
string st;
if (nombre == "Juan") {
    st = "¡Hola amigo!";
}
else if (nombre == "María") {
    st = "Buen día señora";
}
else if (nombre == "Alberto") {
    st = "Hola Alberto";
}
else if (nombre == "") {
    st = "¡Buen día mundo!";
}
else {
    st = $"Buen día {nombre}";
}
Console.WriteLine(st);
```

Switch tradicional:
```C#
Console.WriteLine("Ingrese su nombre:");
string nombre = Console.ReadLine();
string st;
switch (nombre) {
    case "Juan": st = "¡Hola amigo!";
        break;
    case "María": st = "Buen día señora";
        break;
    case "Alberto": st = "Hola Alberto";
        break;
    case "": st = "¡Buen día mundo!";
        break;
    default: st = $"Buen día {nombre}";
        break;
}
Console.WriteLine(st);
```

Expresión switch:
```C#
Console.WriteLine("Ingrese su nombre:");
string nombre = Console.ReadLine();
string st = nombre switch {
    "Juan" => "¡Hola amigo!",
    "María" => "Buen día señora",
    "Alberto" => "Hola Alberto",
    "" => "¡Buen día mundo!",
    _ => $"Buen día {nombre}"
};
Console.WriteLine(st);
```
---
6) Utilizar Console.ReadLine() para leer líneas de texto (secuencia de caracteres que finaliza al presionar \<ENTER>) por la consola. Por cada línea leída se debe imprimir inmediatamente la cantidad de caracteres de la misma. El programa termina al ingresar la cadena vacía.
Tip: si st es una variable de tipo string, entonces st.Length devuelve la cantidad de caracteres del string.
```C#
string st = Console.ReadLine();
while (st != "") {
    Console.WriteLine(st.Length);
    st = Console.ReadLine();
}
```
---
7) Qué hace la instrucción Console.WriteLine("100".Length); ?
> Imprime 3.
---
8) Sea st una variable de tipo string correctamente declarada. ¿Es válida la siguiente instrucción: Console.WriteLine(st=Console.ReadLine());?
> Sí. Espera una entrada por teclado y la imprime.
---
9) Escribir un programa que lea dos palabras separadas por un blanco que terminan con \<ENTER>, y determinar si son simétricas (Ej: 'abbccd' y 'dccbba' son simétricas).
Tip: si st es un string, entonces st\[0] devuelve el primer carácter de st, y st\[st.Length-1]
devuelve el último carácter de st.
```C#
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
```