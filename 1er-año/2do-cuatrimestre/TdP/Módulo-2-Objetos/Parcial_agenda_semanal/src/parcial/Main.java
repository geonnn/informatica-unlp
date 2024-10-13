/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package parcial;

/**
 *
 * @author Gonzalo
 */
public class Main {
    
    public static void main(String[] args) {
        Agenda A = new Agenda();
        Paciente p1 = new Paciente("Carlos", true, 100);
        Paciente p2 = new Paciente("Diego", false, 200);
        Paciente p3 = new Paciente("Benito", true, 150);
        
        A.agendarPaciente(p1, 0, 0);
        A.agendarPaciente(p1, 0, 2);
        A.agendarPaciente(p1, 1, 1);
        A.agendarPaciente(p2, 1, 2);
        A.agendarPaciente(p3, 3, 4);
        
        System.out.println(A.tieneTurno("Carlos", 1));
        A.liberarTurnos("Carlos");
        System.out.println(A.tieneTurno("Carlos", 1));
    }
    
}
