package objetosdos;

import java.time.Duration;
import java.time.LocalDateTime;

// STATE
public abstract class ToDoItemState {
    protected ToDoItem toDoItem;

    protected void setToDoItemState(ToDoItemState state) {
        this.toDoItem.setState(state);
    }

    protected void setToDoItem(ToDoItem toDoItem) {
        this.toDoItem = toDoItem;
    }

    public void start() { }

    public void togglePause() {
        throw new RuntimeException("La tarea no se encuentra pausada o en progreso.");
    }

    public void finish() { }

    public Duration workedTime() {
        return Duration.between(this.toDoItem.getStartTime(), LocalDateTime.now());
    }

    public void addComment(String comment) {
        this.toDoItem.addComment(comment);
    }
}
