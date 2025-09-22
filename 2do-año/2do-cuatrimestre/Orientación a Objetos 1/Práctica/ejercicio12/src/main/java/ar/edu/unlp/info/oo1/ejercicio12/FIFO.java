package ar.edu.unlp.info.oo1.ejercicio12;

import java.util.List;

public class FIFO implements Strategy {

	@Override
	public JobDescription next(List<JobDescription> jobs) {
        return jobs.get(0);
	}
}
