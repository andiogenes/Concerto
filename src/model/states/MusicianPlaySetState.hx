package model.states;

import model.entities.members.Song;
import model.entities.members.Musician;
import utils.StateMachine;

class MusicianPlaySetState extends StateOf<Musician> {
    private static final TIME_STAMP: Float = 0.005;

    var songElapsed: Float = 0;
    var currentSong: Song = null;

    public function new(fsm: StateMachineOf<Musician>) {
        super(fsm);

        // TODO: set stage music quality here
        currentSong = owner.getCurrentSong();
    }

    override public function update() {
        if (owner.hasSongs() == false) {
            fsm.setState(new MusicianLeaveState(fsm));
            return;
        }

        if (songElapsed >= currentSong.duration) {
            songElapsed = 0;

            // TODO: set stage music quality here
            owner.endCurrentSong();
            currentSong = owner.getCurrentSong();
            return;
        }

        songElapsed += TIME_STAMP;
    }
}