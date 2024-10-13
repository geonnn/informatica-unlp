/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ej01denuevo;

/**
 *
 * @author Gonzalo
 */
public class Main {
    
    public static void main(String[] args) {
        Proyecto proyecto1 = new Proyecto("PR y sus Redonditos de Ricota", 1, "Carlos Alberto Solari");
        Investigador inv1 = new Investigador("Skay", 1, "Guitarra");
        Investigador inv2 = new Investigador("Bucciarelli", 2, "Bajo");
        Investigador inv3 = new Investigador("Sidotti", 3, "Batería");
        Subsidio sub1 = new Subsidio(100, "mot1");
        Subsidio sub2 = new Subsidio(200, "mot2");
        Subsidio sub3 = new Subsidio(300, "mot3");
        Subsidio sub4 = new Subsidio(400, "mot4");
        Subsidio sub5 = new Subsidio(500, "mot5");
        Subsidio sub6 = new Subsidio(600, "mot6");
        proyecto1.agregarInvestigador(inv1);
        proyecto1.agregarInvestigador(inv2);
        proyecto1.agregarInvestigador(inv3);
        inv1.agregarSubsidio(sub1);
        inv1.agregarSubsidio(sub2);
        inv2.agregarSubsidio(sub3);
        inv2.agregarSubsidio(sub4);
        inv3.agregarSubsidio(sub5);
        inv3.agregarSubsidio(sub6);
        proyecto1.otorgarTodos("Sidotti");
        proyecto1.otorgarTodos("Skay");
        System.out.println("dinero total proyecto 1: " + proyecto1.dineroTotalOtorgado());
        System.out.println(proyecto1);
    }
    
}
