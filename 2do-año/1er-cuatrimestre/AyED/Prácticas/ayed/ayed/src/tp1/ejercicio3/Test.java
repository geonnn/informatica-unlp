package tp1.ejercicio3;

public class Test {

	public static void main(String[] args) {
		Estudiante[] ests = new Estudiante[2];
		Profesor[] profs = new Profesor[3];
		
		Estudiante est1 = new Estudiante("Gonzalo", "Gil", "5", "gonzaloj_g@hotmail.com", "56 1138");
		Estudiante est2 = new Estudiante("Antonia", "Cabra", "7", "antocaabra@gmail.com", "48 558");
		ests[0] = est1;
		ests[1] = est2;
		
		Profesor prof1 = new Profesor("1", "1", "1", "1", "1");
		Profesor prof2 = new Profesor("2", "2", "2", "2", "2");
		Profesor prof3 = new Profesor("3", "3", "3", "3", "3");
		profs[0] = prof1;
		profs[1] = prof2;
		profs[2] = prof3;

		for (Estudiante est : ests) {
			System.out.println(est.tusDatos());
		}
		
		System.out.println();
		
		for (Profesor prof : profs) {
			System.out.println(prof.tusDatos());
		}
	}

}
