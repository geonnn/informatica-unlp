/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Ej01;

/**
 *
 * @author Gonzalo
 */
public class main {
    
    public static void main(String[] args) {
        Proyecto pro1 = new Proyecto("PR y sus Redonditos de Ricota", 1, "Carlos Alberto Solari");
        Investigador inv1 = new Investigador("Skay", 2, "gtr");
        Investigador inv2 = new Investigador("Bucciarelli", 3, "Bajo");
        Investigador inv3 = new Investigador("Sidotti", 4, "Batería");
        Subsidio sub1 = new Subsidio(1000, "los redondos11");
        Subsidio sub2 = new Subsidio(2000, "los redondos22");
        Subsidio sub3 = new Subsidio(3000, "los redondos33");
        Subsidio sub4 = new Subsidio(4000, "los redondos44");
        Subsidio sub5 = new Subsidio(5000, "los redondos55");
        Subsidio sub6 = new Subsidio(6000, "los redondos66");
        pro1.agregarInvestigador(inv1);
        pro1.agregarInvestigador(inv2);
        pro1.agregarInvestigador(inv3);
        inv1.agregarSubsidio(sub1);
        inv1.agregarSubsidio(sub2);
        inv2.agregarSubsidio(sub3);
        inv2.agregarSubsidio(sub4);
        inv3.agregarSubsidio(sub5);
        inv3.agregarSubsidio(sub6);
        
    }
    
}
