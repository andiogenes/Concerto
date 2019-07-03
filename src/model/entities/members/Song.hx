package model.entities.members;

class Song {
    public var name(default, null): String;
    public var duration(default, set): Int = 0;
    public var quality(default, set): Int = 0;

    public function new(name: String, duration: Int, quality: Int) {
        this.name = name;
        this.duration = duration;
        this.quality = quality;
    }

    function set_duration(_duration: Int): Int {
        if (_duration >= 0) {
            duration = _duration;
        }

        return duration;
    }

    function set_quality(_quality: Int): Int {
        if (_quality >= 0) {
            quality = _quality;
        }

        return quality;
    }
}