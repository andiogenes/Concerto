package model.entities.members;

class Song {
    public var name(default, null): String;
    public var duration(default, set): Int = 0;

    public function new(name: String, duration: Int) {
        this.name = name;
        this.duration = duration;
    }

    function set_duration(_duration: Int): Int {
        if (_duration >= 0) {
            duration = _duration;
        }

        return duration;
    }
}