package model.states;

import utils.Point;
import model.entities.members.Listener;
import utils.StateMachine;

class ListenerLeaveState extends StateOf<Listener> {
    private static final MIN_DISTANCE: Float = 5;

    var destination: Point;

    public function new(fsm: StateMachineOf<Listener>) {
        super(fsm);

        destination = owner.getSpawnPosition();
    }

    override public function update() {
        var vecX = destination.x - owner.x;
        var vecY = destination.y - owner.y;
        var length = Math.sqrt(vecX*vecX + vecY*vecY);

        if (length <= MIN_DISTANCE) {
            fsm.setState(null);
            owner.dispose();
            return;
        }

        owner.x += vecX / length;
        owner.y += vecY / length;
    }
}