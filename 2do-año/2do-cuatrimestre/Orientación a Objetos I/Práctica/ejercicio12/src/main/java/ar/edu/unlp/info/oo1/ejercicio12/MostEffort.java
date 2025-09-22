package ar.edu.unlp.info.oo1.ejercicio12;

import java.util.List;

public class MostEffort implements Strategy {

	@Override
	public JobDescription next(List<JobDescription> jobs) {
		return jobs.stream()
				.max((j1,j2) -> Double.compare(j1.getEffort(), j2.getEffort()))
				.orElse(null);
	}
}
