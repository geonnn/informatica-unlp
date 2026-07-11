package objetosdos;

import java.time.Duration;

// CONCRETE STATE
public class Pending extends ToDoItemState {

    @Override
    public void start() {
        this.toDoItem.setStartTime();
        this.setToDoItemState(new InProgress());
    }

    @Override
    public Duration workedTime() {
        throw new RuntimeException("Todavía no se inició la tarea.");
    }
}
