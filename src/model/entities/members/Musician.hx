package model.entities.members;

import utils.Queue;

class Musician extends ConcertMember {
    private var songs: Queue<Song>;

    public var name(default, null): String;

    public function new(x: Float, y: Float, name: String, ?stage: Stage) {
        super(x, y, stage);

        this.name = name;
        
        songs = new Queue<Song>();
    }

    override public function update() {
    }

    public function addSong(song: Song) {
        songs.push(song);
    }
}