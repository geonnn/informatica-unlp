1) Sin borrar ni modificar ninguna línea, completar la definición de las clases B, C y D.
```csharp
class A
{
	protected int _id;
	public A(int id) => _id = id;
	public virtual void Imprimir() => Console.WriteLine($"A_{_id}");
}
class B : A
{
. . .
}
class C : B
{
. . .
}
class D : C
{
	. . .
	public override void Imprimir()
	{
		. . .
		base.Imprimir();
	}
}
```
Para que el siguiente código produzca la salida indicada:
```csharp
A[] vector = [new A(3),new B(5),new C(15),new D(41)];
foreach (A a in vector)
{
	a.Imprimir();
}
```
```console
A_3
B_5 --> A_5
C_15 --> B_15 --> A_15
D_41 --> C_41 --> B_41 --> A_41
```

```csharp
A[] vector = [new A(3), new B(5), new C(15), new D(41)];
foreach (A a in vector)
{
    a.Imprimir();
}

class A
{
    protected int _id;
    public A(int id) => _id = id;
    public virtual void Imprimir() => Console.WriteLine($"A_{_id}");
}
class B : A
{
    public B(int id) : base(id) { }
    
    public override void Imprimir()
    {
        Console.Write($"B_{_id} --> ");
        base.Imprimir();
    }
}
class C : B
{
    public C(int id) : base(id) { }
    public override void Imprimir()
    {
        Console.Write($"C_{_id} --> ");
        base.Imprimir();
    }
}
class D : C
{
    public D(int id) : base(id) { }
    public override void Imprimir()
    {
        Console.Write($"D_{_id} --> ");
        base.Imprimir();
    }
}

```

---
2) Aunque consultar en el código por el tipo de un objeto indica habitualmente un diseño ineficiente, por motivos didácticos vamos a utilizarlo. Completar el siguiente código, que utiliza las clases definidas en el ejercicio anterior, para que se produzca la salida indicada:
```csharp
A[] vector = [new C(1),new D(2),new B(3),new D(4),new B(5)];
foreach (A a in vector)
{
...
}
```
```console
B_3 --> A_3
B_5 --> A_5
```
Es decir, se deben imprimir sólo los objetos cuyo tipo exacto sea B
- a) Utilizando el operador is
- b) Utilizando el método GetType() y el operador typeof() (investigar sobre éste último en la documentación en línea de .net)

```csharp
A[] vector = [new C(1), new D(2), new B(3), new D(4), new B(5)];
foreach (A a in vector)
{
    if (a.GetType().Equals(typeof(B)))
        a.Imprimir();
}
```
---
3) ¿Por qué no funciona el siguiente código? ¿Cómo se puede solucionar fácilmente?
```csharp
class Auto
{
	double velocidad;
	public virtual void Acelerar() => Console.WriteLine("Velocidad = {0}", velocidad += 10);
}
class Taxi : Auto
{
	public override void Acelerar() => Console.WriteLine("Velocidad = {0}", velocidad += 5);
}
```
La clase Taxi no puede acceder a las variables de instancia de la clase Auto si no son públicas, o mediante un getter/propiedad público/a.

---
4) Contestar sobre el siguiente programa:
```csharp
Taxi t = new Taxi(3);
Console.WriteLine($"Un {t.Marca} con {t.Pasajeros} pasajeros");
class Auto
{
	public string Marca { get; private set; } = "Ford";
	public Auto(string marca) => this.Marca = marca;
	public Auto() { }
}
class Taxi : Auto
{
	public int Pasajeros { get; private set; }
	public Taxi(int pasajeros) => this.Pasajeros = pasajeros;
}
```
> ¿Por qué no es necesario agregar :base en el constructor de Taxi? Eliminar el segundo constructor de la clase Auto y modificar la clase Taxi para el programa siga funcionando.

Al ejecutarse, el constructor de Taxi recurre al constructor vacío de Auto, y la variable marca queda con el valor por defecto "Ford". Si se elimina el constructor vacío, la clase Taxi se ve obligada a utilizar un constructor con `: base(string)`.

```csharp
Taxi t = new Taxi(3, "Fiat");
Console.WriteLine($"Un {t.Marca} con {t.Pasajeros} pasajeros");

class Auto
{
    public string Marca { get; private set; } = "Ford";
    public Auto(string marca) => this.Marca = marca;
}
class Taxi : Auto
{
    public int Pasajeros { get; private set; }
    public Taxi(int pasajeros, string marca) : base(marca)  => this.Pasajeros = pasajeros;
}
```

---
5) Qué líneas del código siguiente provocan error de compilación y por qué?
```csharp
class Persona
{
	public string Nombre { get; set; }
}

public class Auto
{
	private Persona _dueño1, _dueño2; // Inconsistent accessibility: return type 'Persona' is less accessible than method 'Auto.GetPrimerDueño()'
	public Persona GetPrimerDueño() => _dueño1; // Inconsistent accessibility: property type 'Persona' is less accessible than property 'Auto.SegundoDueño'
	protected Persona SegundoDueño
	{
		set => _dueño2 = value;
	}
}
```
Si no se especifica modificador de acceso para una clase, por defecto queda `internal`, lo que significa que es sólo accesible dentro del mismo proyecto. Entonces, la clase Auto siendo pública, no puede exponer un tipo que sea menos accesible.

---
6) Señalar el error en cada uno de los siguientes casos:
```csharp
// (6.1)
class A
{
	public string M1() => "A.M1"; // falta virtual acá para que el método pueda ser overrideado por clases que hereden el método.
}
class B : A
{
	public override string M1() => "B.M1";
}

// (6.2)
class A
{
	public abstract string M1(); // el método abstracto es correcto pero está dentro de una clase no declarada como abstracta.
}
class B : A
{
	public override string M1() => "B.M1";
}

// (6.3)
abstract class A
{
	public abstract string M1() => "A.M1"; // los métodos abstractos no pueden tener declarado un cuerpo.
}
class B : A
{
	public override string M1() => "B.M1";
}

// (6.4)
class A
{
	public override string M1() => "A.M1"; // no existe un método que overridear.
}
class B : A
{
	public override string M1() => "B.M1";
}

// (6.5)
class A
{
	public virtual string M1() => "A.M1";
}
class B : A
{
	protected override string M1() => "B.M1"; // no se puede modificar el acceso al sobreescribir métodos heredados.
}

// (6.6)
class A
{
	public static virtual string M1() => "A.M1"; // A static member cannot be marked as 'virtual'
}
class B : A
{
	public static override string M1() => "B.M1"; // A static member cannot be marked as 'override'
}

// (6.7)
class A
{
	virtual string M1() => "A.M1"; // al no declarar modificador de acceso, el método queda private. Miembros virtuales no pueden ser privados.
}
class B : A
{
	override string M1() => "B.M1"; // ídem clase A.
}

// (6.8)
class A
{
	protected A(int i) { }
}
class B : A
{
	B() { } // B debe invocar un constructor con el parámetro requerido "i".
	// B(int i) : base(i) { }
}

// (6.9)
class A
{
	private int _id;
	protected A(int i) => _id = i;
}
class B : A
{
	B(int i):base(5) {
		_id = i; // B no puede acceder al campo privado de A "_id."
	}
}

// (6.10)
class A
{
	private int Propiedad { set; public get; } // el modificador de acceso del getter debe ser más restrictivo que el modificador de acceso de la propiedad en sí.
	// public int Propiedad { private set; get; }
}
class B : A
{
}

// (6.11)
abstract class A
{
	public abstract int Prop { set; get; }
}
class B : A // B debe implementar el set porque A lo declara.
{
	public override int Prop
	{
		get => 5;
	}
}

// (6.12)
abstract class A
{
	public int Prop {set; get;}
}
class B : A
{
	public override int Prop // no se puede overridear un miembro que no es virtual.
	{
		get => 5;
		set {}
	}
}
```
---
7) Ofrecer una implementación polimórfica para mejorar el siguiente programa:
```csharp
Imprimidor.Imprimir(new A(), new B(), new C(), new D());
class A
{
	public void ImprimirA() => Console.WriteLine("Soy una instancia A");
}
class B
{
	public void ImprimirB() => Console.WriteLine("Soy una instancia B");
}
class C
{
	public void ImprimirC() => Console.WriteLine("Soy una instancia C");
}
class D
{
	public void ImprimirD() => Console.WriteLine("Soy una instancia D");
}
static class Imprimidor
{
	public static void Imprimir(params object[] vector)
	{
		foreach (object o in vector)
		{
			if (o is A a) { a.ImprimirA(); }
			else if (o is B b) { b.ImprimirB(); }
			else if (o is C c) { c.ImprimirC(); }
			else if (o is D d) { d.ImprimirD(); }
		}
	}
}
```

```csharp
Imprimidor.Imprimir(new A(), new B(), new C(), new D());

// todavía no se vieron interfaces en este punto de la cursada así que estaría bien hacerlo con clase abstracta(?
abstract class I
{
    public abstract void Imprimir();
}

class A : I
{
    public override void Imprimir() => Console.WriteLine("Soy una instancia A");
}
class B : I
{
    public override void Imprimir() => Console.WriteLine("Soy una instancia B");
}
class C : I
{
    public override void Imprimir() => Console.WriteLine("Soy una instancia C");
}
class D : I
{
    public override void Imprimir() => Console.WriteLine("Soy una instancia D");
}

static class Imprimidor
{
    public static void Imprimir(params I[] vector)
    {
        foreach (I i in vector)
            i.Imprimir();
    }
}
```
---
8) Crear un programa para gestionar empleados en una empresa. Los empleados deben tener las propiedades públicas de sólo lectura Nombre, DNI, FechaDeIngreso, SalarioBase y Salario. Los valores de estas propiedades (a excepción de Salario que es una propiedad calculada) deben establecerse por medio de un constructor adecuado. Existen dos tipos de empleados: Administrativo y Vendedor. No se podrán crear objetos de la clase padre Empleado, pero sí de sus clases hijas (Administrativo y Vendedor). Aparte de las propiedades de solo lectura mencionadas, el administrativo tiene otra propiedad pública de lectura/escritura llamada Premio y el vendedor tiene otra propiedad pública de lectura/escritura llamada Comision. La propiedad de solo lectura Salario, se calcula como el salario base más la comisión o el premio según corresponda.
   Las clases tendrán además un método público llamado AumentarSalario() que tendrá una implementación distinta en cada clase. En el caso del administrativo se incrementará el salario base en un 1% por cada año de antigüedad que posea en la empresa, en el caso del vendedor se incrementará el salario base en un 5% si su antigüedad es inferior a 10 años o en un 10% en caso contrario.
   El siguiente código (ejecutado el día 9/4/2022) debería mostrar en la consola el resultado indicado:
```csharp
Empleado[] empleados = new Empleado[]
{
	new Administrativo("Ana", 20000000, DateTime.Parse("26/4/2018"), 10000) {Premio=1000},
	new Vendedor("Diego", 30000000, DateTime.Parse("2/4/2010"), 10000) {Comision=2000},
	new Vendedor("Luis", 33333333, DateTime.Parse("30/12/2011"), 10000) {Comision=2000}
};
foreach (Empleado e in empleados)
{
	Console.WriteLine(e);
	e.AumentarSalario();
	Console.WriteLine(e);
}
```
```console
Administrativo Nombre: Ana, DNI: 20000000 Antigüedad: 3
Salario base: 10000, Salario: 11000
-------------
Administrativo Nombre: Ana, DNI: 20000000 Antigüedad: 3
Salario base: 10300, Salario: 11300
-------------
Vendedor Nombre: Diego, DNI: 30000000 Antigüedad: 12
Salario base: 10000, Salario: 12000
-------------
Vendedor Nombre: Diego, DNI: 30000000 Antigüedad: 12
Salario base: 11000, Salario: 13000
-------------
Vendedor Nombre: Luis, DNI: 33333333 Antigüedad: 10
Salario base: 10000, Salario: 12000
-------------
Vendedor Nombre: Luis, DNI: 33333333 Antigüedad: 10
Salario base: 11000, Salario: 13000
-------------
```
> Recomendaciones: Observar que el método AumentarSalario() y la propiedad de solo lectura Salario en la clase Empleado pueden declararse como abstractos. Intentar no usar campos sino propiedades auto-implementadas todas las veces que sea posible. Además sería deseable que la propiedad SalarioBase definida en Empleado sea pública para la lectura y protegida para la escritura, para que pueda establecerse desde las subclases Administrativo y Vendedor.