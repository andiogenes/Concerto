package model.states;

import model.entities.SoundPropagationCone;
import model.entities.Stage;
import utils.StateMachine;
import model.entities.members.Listener;

class ListenerWalkToSceneState extends StateOf<Listener> {
    var stage: Stage;
    var minDistance: Float;
    
    public function new(fsm: StateMachineOf<Listener>) {
        super(fsm);

        stage = owner.getStage();
        minDistance = stage.getCone().radius;
    }

    override public function update() {
        // No musucian on stage => 
        // concert ended => 
        // switch to 'leave concert' state
        if (stage.currentMusician() == null) {
            fsm.setState(new ListenerLeaveState(fsm));
            return;
        }

        var vecX = stage.x - owner.x;
        var vecY = stage.y - owner.y;
        var length = Math.sqrt(vecX*vecX + vecY*vecY);

        // Listener reachs stage =>
        // choose place in front of stage and switch to 'listen' state
        if (length <= minDistance) {
            // TODO: set listener position here
            fsm.setState(new ListenerListenState(fsm));
            return;
        }

        // Move to stage
        owner.x += vecX / length;
        owner.y += vecY / length;
    }
}