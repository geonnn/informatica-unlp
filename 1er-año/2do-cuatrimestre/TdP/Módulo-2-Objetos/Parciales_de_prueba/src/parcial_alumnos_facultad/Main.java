/*
MÓDULO OBJETOS. Cree un proyecto y resuelva en Java. Utilice su apellido como nombre del proyecto.
Entrega: comprima el desarrollo en .zip (no debe incluir ningún archivo .jar) y envíe por correo.
Representar alumnos de una facultad. De cualquier alumno se conoce: DNI, nombre y sus materias aprobadas (como
máximo N). De las materias aprobadas se registra: nombre, nota y fecha. Además de los alumnos de grado se tiene la
carrera, mientras que de los alumnos de doctorado el título universitario y universidad de origen.
1- Genere las clases necesarias. Provea constructores para iniciar las materias aprobadas y los alumnos a partir de la
información necesaria (estos para un máximo de N materias aprobadas y sin materias aprobadas inicialmente).
2- Implemente los métodos necesarios, en las clases que corresponda, para:
a) Dada una materia aprobada, agregarla a las materias aprobadas del alumno.
b) Determinar si el alumno está graduado, teniendo en cuenta que para ello deben tener un total de N materias
aprobadas y deben tener aprobada la materia “Tesis”.
c) Obtener un String que represente al alumno siguiendo el ejemplo:
Ej. alumnos de grado “DNI; Nombre; Materias aprobadas: nombre, nota y fecha de c/u; Está graduado: ...; Carrera”
Ej. alumnos de doctorado “DNI; Nombre; Materias aprobadas: nombre, nota y fecha de c/u; Está graduado: ...; Título;
Universidad de Origen”
3- Realice un programa que instancie un alumno de cada tipo. Cargue información de materias aprobadas a cada
uno. Informe en consola el resultado del inciso c).
*/
package parcial_alumnos_facultad;

/**
 *
 * @author Gonzalo
 */
public class Main {
    
    public static void main(String[] args) {
        
        AlumnoDeGrado alu1 = new AlumnoDeGrado("Sistemas", 43860397, "Gonzalo", 4);
        AlumnoDeDoctorado alu2 = new AlumnoDeDoctorado("Lic. Informática", "UBA", 44111222, "Carlos", 4);
        
        Materia mat1 = new Materia("Matemática 1", 10, new Fecha(10, 10, 2024));
        Materia mat2 = new Materia("CADP", 7, new Fecha(7, 8, 2024));
        Materia mat3 = new Materia("Taller de Programación", 9, new Fecha(31, 11, 2024));
        Materia mat4 = new Materia("Tesis", 9, new Fecha(15, 12, 2024));
        alu1.agregarMateriaAprobada(mat1);
        alu1.agregarMateriaAprobada(mat2);
        alu1.agregarMateriaAprobada(mat3);
        
        alu2.agregarMateriaAprobada(mat1);
        alu2.agregarMateriaAprobada(mat2);
        alu2.agregarMateriaAprobada(mat3);
        alu2.agregarMateriaAprobada(mat4);
        
        System.out.println(alu1);
        System.out.println(alu2);
    }
    
}
