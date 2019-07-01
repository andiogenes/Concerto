package model;

import model.entities.members.Musician;
import model.entities.members.Listener;
import model.entities.MerchStore;
import model.entities.Stage;
import model.entities.ConcertMember;

class MusicVenue {
    private var stage: Stage;
    private var store: MerchStore;
    private var members: List<ConcertMember>;

    public var width(default, null): Float;
    public var height(default, null): Float;
    
    public function new(store: MerchStore, stage: Stage, width: Float = 800, height: Float = 600) {
        this.width = width;
        this.height = height;

        this.store = store;
        this.stage = stage;
        members = new List<ConcertMember>();
    }

    public function update() {
        for (v in members) {
            v.update();

            if (v.isDisposed == true) {
                members.remove(v);
            }
        }
    }

    public function addListener(listener: Listener) {
        members.add(listener);
        
        listener.setStage(stage);
        listener.setStore(store);
    }

    public function addMusician(musician: Musician) {
        members.add(musician);

        stage.enrollMusician(musician);
        
        musician.setStage(stage);
    }

    public function getStore(): MerchStore {
        return store;
    }

    public function getStage(): Stage {
        return stage;
    }

    public function getMembers(): List<ConcertMember> {
        return members;
    }
}