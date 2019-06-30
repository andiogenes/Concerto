package model.entities.members;

class Listener extends ConcertMember {
    private var store: MerchStore;

    public var mood(default, set): Int;
    public var money(default, set): Int;

    public function new(x: Float, y: Float, ?stage: Stage, ?store: MerchStore) {
        super(x, y, stage);

        if (store != null) {
            this.store = store;
        }
    }

    override public function update() {
        
    }

    public function getStore(): MerchStore {
        return store;
    }

    public function setStore(store: MerchStore) {
        this.store = store;
    }

    function set_mood(_mood: Int): Int {
        if (_mood >= 0) {
            mood = _mood;
        }

        return mood;
    }

    function set_money(_money: Int): Int {
        if (_money >= 0) {
            money = _money;
        }

        return money;
    }
}