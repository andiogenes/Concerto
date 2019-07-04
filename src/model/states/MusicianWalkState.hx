package model.states;

import model.entities.Stage;
import utils.StateMachine.StateMachineOf;
import utils.StateMachine.StateOf;
import model.entities.members.Musician;

class MusicianWalkState extends StateOf<Musician> {
    private static final MIN_DISTANCE: Float = 5;
    
    var stage: Stage;

    public function new(fsm: StateMachineOf<Musician>) {
        super(fsm);

        stage = owner.getStage();
        
        stage.isInPreparation = true;
    }

    override public function update() {
        var vecX = stage.x - owner.x;
        var vecY = stage.y - owner.y;
        var length = Math.sqrt(vecX*vecX + vecY*vecY);

        if (length <= MIN_DISTANCE) {
            fsm.setState(new MusicianTuneUpState(fsm));
            return;
        }

        owner.x += vecX / length;
        owner.y += vecY / length;
    }
}