package model.states;

import model.entities.SoundPropagationCone;
import model.entities.Stage;
import model.entities.members.Listener;
import utils.StateMachine;

class ListenerListenState extends StateOf<Listener> {
    private static final MOOD_REFRESH_INTERVAL: Float = 5;
    private static final TIME_STAMP: Float = 0.05;

    private static final SOUND_QUALITY_PENALTY: Int = 20;
    private static final MUSIC_QUALITY_PENALTY: Int = 30;
    private static final MAXIMAL_WAITING_DURATION: Int = 60;
    private static final WAITING_STEP: Float = 0.05;

    var elapsed: Float = 0;

    var waitingMoodDecay = 0.;

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
        if (owner.mood >= Listener.HOT_MOOD_THRESHOLD && !owner.boughtItem) {
            stage.listenersCount--;
            fsm.setState(new ListenerWalkToStoreState(fsm));
            return;
        }

        if (elapsed >= MOOD_REFRESH_INTERVAL) {
            // Equation of listener's mood from stage's means quality
            owner.mood += Std.int((stage.soundQuality - SOUND_QUALITY_PENALTY) / 10);

            if (stage.isInPreparation) {
                // Equation of mood from tune up duration
                waitingMoodDecay += WAITING_STEP;
                owner.mood -= Std.int(1/(MAXIMAL_WAITING_DURATION - waitingMoodDecay)-(1/MAXIMAL_WAITING_DURATION));
            } else {
                // Equation of mood from musician, songs

                if (waitingMoodDecay != 0) {
                    waitingMoodDecay = 0;
                }

                owner.mood += Std.int((stage.musicQuality - MUSIC_QUALITY_PENALTY) / 10);

                var distanceX = stage.x - owner.x;
                var distanceY = stage.y - owner.y;
                var distanceToScene = Math.sqrt(distanceX*distanceX+distanceY*distanceY);

                // Equation of mood from remoteness of scene
                if (distanceToScene > cone.radius) {
                    owner.mood -= Std.int((distanceToScene / cone.radius) * 5);
                }
            }

            elapsed = 0;
        }

        elapsed += TIME_STAMP;
    }
}