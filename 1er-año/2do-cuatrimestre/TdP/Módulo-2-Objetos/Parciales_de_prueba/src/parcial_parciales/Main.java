/*
MÓDULO OBJETOS. 17/07/2021
IMPORTANTE: Cree un proyecto y resuelva en Java. Utilice su apellido como nombre del proyecto.
Entrega: comprima el desarrollo en .zip (no debe incluir ningún archivo .jar) y envíe por correo.
Representar fechas de parcial tomadas por una cátedra. Una fecha de parcial guarda información de las N
salas en las que se distribuyeron los alumnos. Cada sala almacena información de los alumnos que rindieron
en ella (como máximo M). De los alumnos registra: nombre, DNI y nro. de tema asignado.
1- Genere las clases necesarias. Provea constructores para iniciar: las fechas de parcial para N salas y un
máximo de M alumnos por sala (inicialmente sin alumnos); los alumnos a partir de DNI y nombre (inicialmente
con nro. de tema indefinido -1).
2- Implemente los métodos necesarios, en las clases que corresponda, para:
a. Agregar un alumno a la sala X de la fecha. Asuma que X es válido y que hay lugar para el alumno.
b. Asignar un tema a todos los alumnos de la fecha, de la siguiente manera: a los alumnos de una misma
sala se le asignan temas al azar (entre 1 y M).
c. Obtener un String con la información de los alumnos (nombre, DNI) que rinden el tema T.
3- Realice un programa que instancie una fecha de parcial para 2 salas y 4 alumnos por sala. Agregue
alumnos a la fecha, asigne temas a todos los alumnos y luego muestre la información obtenida del inciso c.
*/
package parcial_parciales;

/**
 *
 * @author Gonzalo
 */
public class Main {
    
    public static void main(String[] args) {
        
        FechaDeParcial f1 = new FechaDeParcial(2, 4);
        Alumno alu1 = new Alumno("Gonzalo", 43860397);
        Alumno alu2 = new Alumno("Lionel", 43111111);
        Alumno alu3 = new Alumno("Diego", 43222222);
        Alumno alu4 = new Alumno("Juan Sebastián", 43333333);
        
        f1.agregarAlumno(0, alu1);
        f1.agregarAlumno(0, alu2);
        f1.agregarAlumno(1, alu4);
        f1.agregarAlumno(1, alu3);
        
        f1.asignarTemaATodos(4);
        System.out.println(f1.toStringAlumnosTema(1));
        
    }
    
}
