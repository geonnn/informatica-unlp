package objetosdos;

import java.time.Duration;

// CONCRETE STATE
public class Finished extends ToDoItemState {

    @Override
    public Duration workedTime() {
        return Duration.between(this.toDoItem.getStartTime(), this.toDoItem.getFinishTime());
    }

    @Override
    public void addComment(String comment) {
        // comentar una tarea finalizada hace nada.
    }
}
