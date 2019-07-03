package view;

import model.entities.members.Listener;
import model.entities.members.Musician;
import model.MusicVenue;

class View {
    private var venue: MusicVenue;

    var stageDisplay: Image;
    var storeDisplay: Image;
    var listenerSadDisplay: Image;
    var listenerNormalDisplay: Image;
    var listenerEngagedDisplay: Image;
    var listenerHotDisplay: Image;
    var bandDisplay: Image;
    var toolDisplay: Image;
    var creamDisplay: Image;

    private function new(venue: MusicVenue) {
        this.venue = venue;

        init();
        loadAssets();
    }

    private function init() {
        throw "Error: unimplemented method init";
    }

    private function loadAssets() {
        stageDisplay = loadImage('assets/stage.png');
        storeDisplay = loadImage('assets/store.png');
        listenerSadDisplay = loadImage('assets/listener-sad.png');
        listenerNormalDisplay = loadImage('assets/listener-normal.png');
        listenerEngagedDisplay = loadImage('assets/listener-engaged.png');
        listenerHotDisplay = loadImage('assets/listener-hot.png');
        bandDisplay = loadImage('assets/band.png');
        toolDisplay = loadImage('assets/tool.png');
        creamDisplay = loadImage('assets/cream.png');
    }

    private function loadImage(path: String): Image {
        throw "Error: unimplemented method loadImage";
        return null;
    }

    private function update() {
        venue.update();
        draw();
    }

    private function draw() {
        clearScene();

        storeDisplay.draw(venue.getStore().x, venue.getStore().y);

        drawCone();
        stageDisplay.draw(venue.getStage().x, venue.getStage().y);

        drawMembers();
        
        var musician = venue.getStage().getCurrentMusician();
        printText(10, venue.height - 50, 'Musician: ${if (musician == null) "none" else musician.name}');
        
        var song = if (musician == null) null else musician.getCurrentSong();
        printText(10, venue.height - 20, 'Song: ${if (song == null) "none" else song.name}');
    }

    private function clearScene() {
        throw "Error: unimplemented method clearScene";
    }

    private function drawCone() {
        throw "Error: unimplemented method drawCone";
    }

    private function printText(x: Float, y: Float, caption: String) {
        throw "Error: unimplemented method printText";
    }

    function drawMembers() {
        for (v in venue.getMembers()) {
            switch (v.objectType) {
                case Musician.TYPE:
                    var musician: Musician = cast(v);
                    if (musician.name == "Cream") {
                        creamDisplay.draw(musician.x, musician.y);
                    } else if (musician.name == "Tool") {
                        toolDisplay.draw(musician.x, musician.y);
                    } else {
                        bandDisplay.draw(musician.x, musician.y);
                    }

                case Listener.TYPE:
                    var listener: Listener = cast(v);
                    if (listener.mood >= 80) {
                        listenerHotDisplay.draw(listener.x, listener.y);
                    } else if (listener.mood >= 60 && listener.mood < 80) {
                        listenerEngagedDisplay.draw(listener.x, listener.y);
                    } else if (listener.mood >= 40 && listener.mood < 60) {
                        listenerNormalDisplay.draw(listener.x, listener.y);
                    } else {
                        listenerSadDisplay.draw(listener.x, listener.y);
                    }
            }
        }
    }

    public static function create(venue: MusicVenue): View {
    #if concerto_js
        return new view.JSView(venue);
    #elseif concerto_heaps
        return new HeapsView(venue);
    #end
    }
}