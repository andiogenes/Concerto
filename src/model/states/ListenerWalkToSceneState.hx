package model.states;

import model.entities.SoundPropagationCone;
import model.entities.Stage;
import utils.StateMachine;
import model.entities.members.Listener;

class ListenerWalkToSceneState extends StateOf<Listener> {
    var stage: Stage;
    var cone: SoundPropagationCone;

    var minDistance: Float;
    var minAngle: Float;
    var maxAngle: Float;
    
    public function new(fsm: StateMachineOf<Listener>) {
        super(fsm);

        stage = owner.getStage();
        cone = stage.getCone();

        minDistance = cone.radius;

        calculateAngles();
    }

    function calculateAngles() {
        var dirLen = Math.sqrt(cone.getDirection().x*cone.getDirection().x+cone.getDirection().y*cone.getDirection().y);
        var dirAngle = Math.acos(cone.getDirection().x/dirLen);
        minAngle = dirAngle - cone.angle/2;
        maxAngle = dirAngle + cone.angle/2;
    }

    override public function update() {
        // No musucian on stage => 
        // concert ended => 
        // switch to 'leave concert' state
        if (stage.getCurrentMusician() == null) {
            fsm.setState(new ListenerLeaveState(fsm));
            return;
        }

        var vecX = stage.x - owner.x;
        var vecY = stage.y - owner.y;
        var length = Math.sqrt(vecX*vecX + vecY*vecY);

        // Listener reachs stage =>
        // choose place in front of stage and switch to 'listen' state
        if (length <= minDistance) {
            stage.listenersCount++;

            var angle = utils.Random.randomizeF(minAngle, maxAngle);
            var radius = if (stage.capacity == 0 || cone.angle == 0) {
                5;
            } else {
                (stage.listenersCount/stage.capacity) *
                 Math.sqrt((2*stage.capacity)/(Stage.CAPACITY_CONSTRAINT_KOEF*cone.angle));
            }

            if (radius < 30 && radius < cone.radius) {
                radius = cone.radius/2 + radius * 0.25;
            }

            var x = Math.cos(angle)*radius;
            var y = Math.sin(angle)*radius;

            owner.x = stage.x + x;
            owner.y = stage.y + y;

            fsm.setState(new ListenerListenState(fsm));
            return;
        }

        // Move to stage
        owner.x += vecX / length;
        owner.y += vecY / length;
    }
}