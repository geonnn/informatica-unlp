package objetosdos;

// CONCRETE STATE
public class InProgress extends ToDoItemState {

    @Override
    public void togglePause() {
        this.setToDoItemState(new Paused());
    }

    @Override
    public void finish() {
        this.toDoItem.setFinishTime();
        this.setToDoItemState(new Finished());
    }
}
