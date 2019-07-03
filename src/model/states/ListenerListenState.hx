package model.states;

import model.entities.SoundPropagationCone;
import model.entities.Stage;
import model.entities.members.Listener;
import utils.StateMachine;

class ListenerListenState extends StateOf<Listener> {
    private static final MOOD_REFRESH_INTERVAL: Float = 5;
    private static final TIME_STAMP: Float = 0.05;

    var elapsed: Float = 0;

    var stage: Stage;
    var cone: SoundPropagationCone;

    public function new(fsm: StateMachineOf<Listener>) {
        super(fsm);

        stage = owner.getStage();
        cone = stage.getCone();
    }

    override public function update() {
        // No musician => concert is ended
        // Mood == 0 => bad concert
        if (stage.getCurrentMusician() == null || owner.mood == 0) {
            stage.listenersCount--;
            fsm.setState(new ListenerLeaveState(fsm));
            return;
        }

        // Mood >= 80 => walk to store
        if (owner.mood >= 80 && !owner.boughtItem) {
            stage.listenersCount--;
            fsm.setState(new ListenerWalkToStoreState(fsm));
            return;
        }

        if (elapsed >= MOOD_REFRESH_INTERVAL) {
            // MOOD = SONG_QUALITY + SOUND_QUALITY - DISTANCE_PENALTY - WAITING
            owner.mood += 5;
            elapsed = 0;
        }

        elapsed += TIME_STAMP;
    }
}