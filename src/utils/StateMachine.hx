package utils;

class StateOf<T> {
    private var fsm: StateMachineOf<T>;
    private var owner: T;

    private function new(fsm: StateMachineOf<T>) {
        setFSM(fsm);
        setOwner(fsm.getOwner());
    }

    public function update() {}

    public function getOwner() {
        return owner;
    }

    public function setOwner(owner: T) {
        this.owner = owner;
    }

    public function getFSM(): StateMachineOf<T> {
        return fsm;
    }

    public function setFSM(fsm: StateMachineOf<T>) {
        this.fsm = fsm;
    }

}

class StateMachineOf<T> {
    private var state: StateOf<T> = null;
    private var owner: T;

    public function new(owner: T) {
        this.owner = owner;
    }

    public function update() {
        if (state != null) {
            state.update();
        }
    }

    public function getState(): StateOf<T> {
        return state;
    }

    public function setState(state: StateOf<T>) {
        this.state = state;
    }

    public function setOwner(owner: T) {
        this.owner = owner;
    }

    public function getOwner(): T {
        return owner;
    }
}