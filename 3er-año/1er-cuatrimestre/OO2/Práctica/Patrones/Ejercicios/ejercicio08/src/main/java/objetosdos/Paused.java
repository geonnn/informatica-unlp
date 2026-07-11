package objetosdos;

// CONCRETE STATE
public class Paused extends ToDoItemState {

    @Override
    public void togglePause() {
        this.setToDoItemState(new InProgress());
    }

    @Override
    public void finish() {
        this.toDoItem.setFinishTime();
        this.setToDoItemState(new Finished());
    }
}
