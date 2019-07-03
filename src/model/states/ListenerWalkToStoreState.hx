package model.states;

import model.entities.Stage;
import model.entities.members.Listener;
import utils.StateMachine;
import model.entities.MerchStore;

class ListenerWalkToStoreState extends StateOf<Listener> {
    private static final MIN_DISTANCE: Float = 5;

    var stage: Stage;
    var store: MerchStore;

    public function new(fsm: StateMachineOf<Listener>) {
        super(fsm);

        stage = owner.getStage();
        store = owner.getStore();
    }

    override public function update() {
        // No musucian on stage => 
        // concert ended => 
        // switch to 'leave concert' state
        if (stage.getCurrentMusician() == null) {
            fsm.setState(new ListenerLeaveState(fsm));
            return;
        }

        var vecX = store.x - owner.x;
        var vecY = store.y - owner.y;
        var length = Math.sqrt(vecX*vecX + vecY*vecY);

        // Listener reachs store =>
        // try to buy some merch and switch to 'walk to scene' state
        if (length <= MIN_DISTANCE) {
            // Listener buys item what his or her wallet allows
            var merch = store.getMerchandise();

            for (v in merch) {
                if (v.price <= owner.money) {
                    var item = store.dispense(v);
                    
                    owner.money -= item.price;
                    owner.mood += item.quality;
                    
                    break;
                }
            }

            owner.boughtItem = true;

            fsm.setState(new ListenerWalkToSceneState(fsm));
            return;
        }

        // Move to store
        owner.x += vecX / length;
        owner.y += vecY / length;
    }
}