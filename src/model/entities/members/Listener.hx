package model.entities.members;

import utils.StateMachine.StateMachineOf;
import utils.StateMachine.StateOf;
import model.states.ListenerWalkToSceneState;

class Listener extends ConcertMember {
    public static final TYPE: String = "Listener";

    private var fsm: StateMachineOf<Listener>;

    private var store: MerchStore;

    public var mood(default, set): Int;
    public var money(default, set): Int;

    public function new(x: Float, y: Float, mood: Int, money: Int, ?stage: Stage, ?store: MerchStore) {
        super(x, y, stage);

        if (store != null) {
            this.store = store;
        }

        this.mood = mood;
        this.money = money;
        
        this.objectType = TYPE;

        fsm = new StateMachineOf<Listener>(this);
        fsm.setState(new ListenerWalkToSceneState(fsm));
    }

    override public function update() {
        fsm.update();
    }

    public function getStore(): MerchStore {
        return store;
    }

    public function setStore(store: MerchStore) {
        this.store = store;
    }

    function set_mood(_mood: Int): Int {
        if (_mood >= 0) {
            mood = _mood;
        }

        return mood;
    }

    function set_money(_money: Int): Int {
        if (_money >= 0) {
            money = _money;
        }

        return money;
    }
}