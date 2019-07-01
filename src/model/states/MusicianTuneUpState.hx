package model.states;

import utils.StateMachine;
import model.entities.members.Musician;

class MusicianTuneUpState extends StateOf<Musician> {
    private static final TIME_STAMP: Float = 0.005;

    var elapsed: Float = 0;

    public function new(fsm: StateMachineOf<Musician>) {
        super(fsm);
    }

    override public function update() {
        if (elapsed >= owner.tuneUpDuration) {
            fsm.setState(new MusicianPlaySetState(fsm));
            return;
        }

        elapsed += TIME_STAMP;
    }
}