/*
Módulo Objetos
IMPORTANTE: Cree un proyecto y resuelva en Java. Utilice su apellido como nombre del proyecto.
Entrega: comprima el desarrollo en .zip (no debe incluir ningún archivo .jar) y envíe por correo.
Un psicólogo necesita un sistema para organizar su agenda semanal. El sistema mantiene para c/u de los 5 días
de atención y c/u de los 6 turnos (horarios) del día, la información del paciente que tomó el turno. De los
pacientes guarda: nombre, si tiene obra social y costo a abonar por la sesión.
a) Genere las clases necesarias. Implemente constructores para iniciar: el sistema sin pacientes; los pacientes
a partir de toda su información.
b) Lea atentamente y luego implemente métodos que permitan:
- Agendar al paciente P en un día D y turno T. Asuma que el turno está libre. D y T son válidos.
- Dado el nombre de un paciente, liberar todos sus turnos.
- Dado un día D y el nombre de un paciente, devolver si el paciente tiene agendado un turno ese día. Asuma
que D es válido.
c) Realice un programa que instancie el sistema. Cargue varios pacientes al sistema. Libere turnos agendados.
Para finalizar, imprima el resultado del inciso b.iii.
*/

package parcial_agenda_semanal;

/**
 *
 * @author Gonzalo
 */
public class Agenda {
    private final int DIAS = 5;
    private final int TURNOS = 6;
    private Paciente[][] matriz;

    public Agenda() {
        this.setMatriz();
    }

    private void setMatriz() {
        this.matriz = new Paciente[this.getDIAS()][this.getTURNOS()];
        for (int i = 0; i < this.getDIAS(); i++)
            for (int j = 0; j < this.getTURNOS(); j++)
                this.matriz[i][j] = null;
    }

    private int getDIAS() {
        return this.DIAS;
    }

    private int getTURNOS() {
        return this.TURNOS;
    }
    
    private Paciente[][] getMatriz() {
        return this.matriz;
    }
    
    private void setPaciente(Paciente P, int D, int T) {
        this.matriz[D][T] = P;
    }
    
    public void agendarPaciente(Paciente P, int D, int T) {
        this.setPaciente(P, D, T);
        System.out.println("Paciente " + P.getNombre() + " agendado al día " + D + " turno " + T);
    }
    
    public void liberarTurnos(String nom) {
        int D = this.getDIAS();
        int T = this.getTURNOS();
        for (int i = 0; i < D; i++)
            for (int j = 0; j < T; j++)
                if ((this.getMatriz()[i][j]) != null && (this.getMatriz()[i][j].getNombre().equals(nom)))
                    setPaciente(null, i, j);
    }
    
    public boolean tieneTurno(String nom, int D) {
        boolean encontro = false;
        for (int i = 0; i < this.getTURNOS(); i++)
            if ((this.getMatriz()[D][i] != null) && (this.getMatriz()[D][i].getNombre().equals(nom)))
                encontro = true;
        return encontro;
    }
    
}