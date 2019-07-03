package model.states;

import model.entities.members.Listener;
import utils.StateMachine;

class ListenerListenState extends StateOf<Listener> {
    private static final MOOD_REFRESH_INTERVAL: Float = 5;
    private static final TIME_STAMP: Float = 0.75;

    var elapsed: Float = 0;

    public function new(fsm: StateMachineOf<Listener>) {
        super(fsm);
    }

    override public function update() {
        // MOOD = SONG_QUALITY + SOUND_QUALITY - DISTANCE_PENALTY - WAITING 
    }
}