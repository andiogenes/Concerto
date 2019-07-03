package app;

import model.entities.members.Listener;
import model.entities.members.Song;
import model.entities.members.Musician;
import model.entities.SoundPropagationCone;
import model.entities.Stage;
import model.entities.Merchandise;
import model.entities.MerchStore;
import utils.Point;
import model.MusicVenue;

typedef ModelBuilderSong = {_name: String, _duration: Int, _quality: Int};

typedef ModelBuilderMusician = {
    var x: Float;
    var y: Float;
    var name: String;
    var tuneUpDuration: Int;
    var songs: List<ModelBuilderSong>;
}    

class ModelBuilder { 
    private var storePosition: Point;
    private var stagePosition: Point;

    private var coneRadius: Float = 0;
    private var coneAngle: Float = 0;
    private var coneDirection: Point;

    private var storeItems: List<{_price: Int, _quality: Int}>;
    private var musicians: List<ModelBuilderMusician>;
    private var listeners: List<{_x: Float, _y: Float, _mood: Int, _money: Int}>;

    private var musicianPrototype: ModelBuilderMusician;
    private var songsPrototype: List<ModelBuilderSong>;

    private var soundQuality: Int = 0;

    private var width: Float = 0;
    private var height: Float = 0;

    public function new() {
        storePosition = new Point(0, 0);
        stagePosition = new Point(0, 0);

        coneDirection = new Point(0, 0);

        storeItems = new List<{_price: Int, _quality: Int}>();
        musicians = new List<ModelBuilderMusician>();
        listeners = new List<{_x: Float, _y: Float, _mood: Int, _money: Int}>();

        musicianPrototype = {x: 0, y: 0, name: "", tuneUpDuration: 0, songs: null};
        songsPrototype = new List<ModelBuilderSong>();
    }

    public function setSize(width: Float, height: Float) {
        this.width = width;
        this.height = height;

        return this;
    }

    public function setStorePosition(x: Float, y: Float) {
        storePosition.x = x;
        storePosition.y = y;

        return this;
    }

    public function addItemToStore(price: Int, quality: Int) {
        storeItems.add({_price: price, _quality: quality});

        return this;
    }

    public function setStagePosition(x: Float, y: Float) {
        stagePosition.x = x;
        stagePosition.y = y;

        return this;
    }

    public function setConeRadius(radius: Float) {
        coneRadius = radius;

        return this;
    }

    public function setConeAngle(angle: Float) {
        coneAngle = angle;

        return this;
    }

    public function setConeDirection(x: Float, y: Float) {
        coneDirection.x = x;
        coneDirection.y = y;

        return this;
    }

    public function setSoundQuality(quality: Int) {
        soundQuality = quality;

        return this;
    }

    public function setMusicianData(x: Float, y: Float, name: String, tuneUpDuration: Int) {
        musicianPrototype.x = x;
        musicianPrototype.y = y;
        musicianPrototype.name = name;
        musicianPrototype.tuneUpDuration = tuneUpDuration;

        return this;
    }

    public function cleanUpMusician() {
        setMusicianData(0, 0, "", 0);
        clearSongList();

        return this;
    }

    public function removeMusicicans() {
        musicians.clear();

        return this;
    }

    public function addSongToList(name: String, duration: Int, quality: Int) {
        songsPrototype.add({_name: name, _duration: duration, _quality: quality});

        return this;
    }

    public function clearSongList() {
        songsPrototype = new List<ModelBuilderSong>();

        return this;
    }

    public function addMusician() {
        musicians.add({
            x: musicianPrototype.x,
            y: musicianPrototype.y,
            name: musicianPrototype.name,
            tuneUpDuration: musicianPrototype.tuneUpDuration,
            songs: songsPrototype
        });

        cleanUpMusician();

        return this;
    }

    public function addListener(x: Float, y: Float, mood: Int, money: Int) {
        listeners.add({_x: x, _y: y, _mood: mood, _money: money});
        
        return this;
    }

    public function getModel(): MusicVenue {
        var store = new MerchStore(storePosition.x, storePosition.y);
        for (v in storeItems) {
            store.addItem(new Merchandise(v._price, v._quality));
        }

        var stage = new Stage(stagePosition.x, stagePosition.y);
        stage.setCone(new SoundPropagationCone(coneRadius, coneAngle, coneDirection));
        stage.soundQuality = soundQuality;

        var venue = new MusicVenue(store, stage, width, height);
        
        for (v in musicians) {
            var musician = new Musician(v.x, v.y, v.name, v.tuneUpDuration, stage);
            for (s in v.songs) {
                musician.addSong(new Song(s._name, s._duration, s._quality));
            }
            venue.addMusician(musician);
        }

        for (v in listeners) {
            venue.addListener(new Listener(v._x, v._y, v._mood, v._money, stage, store));
        }

        return venue;
    }
}