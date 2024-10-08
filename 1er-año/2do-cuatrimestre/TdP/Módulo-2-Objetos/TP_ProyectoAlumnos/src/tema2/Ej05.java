/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tema2;

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

/**
 *
 * @author gonza
 */
public class Ej05 {
    
    private static final int DF = 20;
    
    public static void main(String[] args) {
        
        GeneradorAleatorio.iniciar();
        
        Partido[] vecPartidos = new Partido[DF];
        
        String eqLoc, eqVis;
        int golesLoc, golesVis, DL = 0;
        
//        System.out.println("Ingrese equipo visitante: ");
//        eqVis = Lector.leerString();
//        while ((DL < DF) && !(eqVis.equals("ZZZ"))) {
//        
//            System.out.println("Ingrese equipo local: ");
//            eqLoc = Lector.leerString();
//            System.out.println("Ingrese goles del equipo visitante: ");
//            golesVis = Lector.leerInt();
//            System.out.println("Ingrese goles del equipo local: ");
//            golesLoc = Lector.leerInt();
//            vecPartidos[DL] = new Partido(eqLoc, eqVis, golesLoc, golesVis);
//            DL++;
//            System.out.println("Ingrese equipo visitante: ");
//            eqVis = Lector.leerString();
//        }

        String[] vecEquipos = {"Estudiantes", "Gimnasia", "River", "Boca", "Independiente", "Racing"};
        
        eqVis = vecEquipos[GeneradorAleatorio.generarInt(6)];
        while ((DL < DF) && !(eqVis.equals("ZZZ"))) {
            eqLoc = vecEquipos[GeneradorAleatorio.generarInt(6)];
            golesVis = GeneradorAleatorio.generarInt(8);
            golesLoc = GeneradorAleatorio.generarInt(8);
            vecPartidos[DL] = new Partido(eqLoc, eqVis, golesLoc, golesVis);
            DL++;
            eqVis = vecEquipos[GeneradorAleatorio.generarInt(6)];
        }
        
        int ganadosRiver = 0, golesBoca = 0;
        
        for (int i = 0; i < DL; i++) {
            System.out.println(vecPartidos[i].toString());
            if (vecPartidos[i].getGanador().equals("River"))
                ganadosRiver++;
            if (vecPartidos[i].getLocal().equals("Boca"))
                golesBoca += vecPartidos[i].getGolesLocal();
            else
                if (vecPartidos[i].getVisitante().equals("Boca"))
                    golesBoca += vecPartidos[i].getGolesVisitante();
        }
        
        System.out.println("River ganó " + ganadosRiver + " partidos.");
        System.out.println("Boca hizo " + golesBoca + " goles.");
    }
    
}