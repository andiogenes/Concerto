package model.states;

import model.entities.members.Song;
import model.entities.members.Musician;
import utils.StateMachine;

class MusicianPlaySetState extends StateOf<Musician> {
    private static final TIME_STAMP: Float = 0.75;

    var songElapsed: Float = 0;
    var currentSong: Song = null;

    public function new(fsm: StateMachineOf<Musician>) {
        super(fsm);

        currentSong = owner.getCurrentSong();

        if (currentSong != null) {
            owner.getStage().musicQuality = currentSong.quality;
        }
    }

    override public function update() {
        if (owner.hasSongs() == false) {
            // no songs => leave concert, next musician plays on stage
            owner.getStage().musicQuality = 0;
            owner.getStage().endMusician();
            owner.getStage().callCurrentMusicianToScene();

            fsm.setState(new MusicianLeaveState(fsm));
            return;
        }

        if (songElapsed >= currentSong.duration) {
            songElapsed = 0;

            owner.endCurrentSong();
            currentSong = owner.getCurrentSong();

            if (currentSong != null) {
                owner.getStage().musicQuality = currentSong.quality;
            }
            return;
        }

        songElapsed += TIME_STAMP;
    }
}