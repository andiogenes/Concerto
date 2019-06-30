package model.entities.members;

class Musician extends ConcertMember {
    private var songs: List<Song>;

    public var name(default, null): String;

    public function new(x: Float, y: Float, name: String, ?stage: Stage) {
        super(x, y, stage);

        this.name = name;
        
        songs = new List<Song>();
    }

    override public function update() {
    }

    public function addSong(song: Song) {
        songs.add(song);
    }
}