package model.entities.members;

import model.states.MusicianWalkState;
import utils.StateMachine.StateMachineOf;
import utils.Queue;

class Musician extends ConcertMember {
    private var fsm: StateMachineOf<Musician>;

    private var songs: Queue<Song>;

    public var name(default, null): String;
    public var tuneUpDuration(default, set): Int;

    public function new(x: Float, y: Float, name: String, duration: Int = 0, ?stage: Stage) {
        super(x, y, stage);

        this.name = name;
        this.tuneUpDuration = duration;
        
        songs = new Queue<Song>();
        fsm = new StateMachineOf<Musician>(this);
    }

    override public function update() {
        fsm.update();
    }

    public function addSong(song: Song) {
        songs.push(song);
    }

    public function informAboutPerformance() {
        fsm.setState(new MusicianWalkState(fsm));
    }

    function set_tuneUpDuration(_duration: Int): Int {
        if (_duration >= 0) {
            tuneUpDuration = _duration;
        }

        return tuneUpDuration;
    }
}