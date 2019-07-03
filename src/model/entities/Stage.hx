package model.entities;

import utils.Point;
import utils.Queue;
import model.entities.members.Musician;

class Stage {
    private var position: Point;
    private var musiciansQueue: Queue<Musician>;
    private var cone: SoundPropagationCone;
    
    public var x(get, null): Float;
    public var y(get, null): Float;
    public var musicQuality(default, set): Int = 0;
    public var soundQuality(default, set): Int = 0;

    public function new(x: Float, y: Float) {
        position = new Point(x, y);

        musiciansQueue = new Queue<Musician>();
    }

    public function enrollMusician(musician: Musician) {
        musiciansQueue.push(musician);
    }

    public function getCurrentMusician(): Musician {
        return musiciansQueue.first();
    }

    public function callCurrentMusicianToScene() {
        var musician = getCurrentMusician();

        if (musician != null) {
            musician.informAboutPerformance();
        }
    }

    public function endMusician(): Musician {
        return musiciansQueue.pop();
    }

    public function getCone(): SoundPropagationCone {
        return cone;
    }

    public function setCone(cone: SoundPropagationCone) {
        this.cone = cone;
    }

    function set_musicQuality(_musicQuality: Int): Int {
        if (_musicQuality >= 0) {
            musicQuality = _musicQuality;
        }

        return musicQuality;
    }

    function set_soundQuality(_soundQuality: Int): Int {
        if (_soundQuality >= 0) {
            soundQuality = _soundQuality;
        }

        return soundQuality;
    }

    function get_x(): Float {
        return position.x;
    }

    function get_y(): Float {
        return position.y;
    }
}