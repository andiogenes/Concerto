package model.entities;

import utils.Point;
import utils.Queue;
import model.entities.members.Musician;

class Stage {
    private static final CAPACITY_CONSTRAINT_KOEF = 0.00778;

    private var position: Point;
    private var musiciansQueue: Queue<Musician>;
    private var cone: SoundPropagationCone;
    
    public var x(get, null): Float;
    public var y(get, null): Float;
    public var musicQuality(default, set): Int = 0;
    public var soundQuality(default, set): Int = 0;
    
    public var capacity(default, null): Int = 0;
    public var listenersCount(default, set): Int = 0;

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
        setCapacity();
    }

    private function setCapacity() {
        var coneArea = (cone.angle * cone.radius * cone.radius) / 2;

        capacity = Math.round(coneArea * CAPACITY_CONSTRAINT_KOEF);
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

    function set_listenersCount(_listenersCount: Int): Int {
        if (_listenersCount >= 0) {
            listenersCount = _listenersCount;
        }

        return listenersCount;
    }
}