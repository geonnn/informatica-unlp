using teoria6;

Empleado[] empleados = new Empleado[] {
    new Administrativo("Ana", 20000000, new DateTime(2018, 04, 26), 10000) {Premio=1000},
    new Vendedor("Diego", 30000000, new DateTime(2010, 04, 02), 10000) {Comision=2000},
    new Vendedor("Luis", 33333333, new DateTime(2011, 12, 30), 10000) {Comision=2000}
};
foreach (Empleado e in empleados)
{
    Console.WriteLine(e);
    e.AumentarSalario();
    Console.WriteLine(e);
}