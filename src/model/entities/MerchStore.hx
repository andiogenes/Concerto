package model.entities;

import utils.Point;

class MerchStore {
    private var merchandise: List<Merchandise>;
    private var position: Point;

    public var x(get, null): Float;
    public var y(get, null): Float;

    public function new(x: Float, y: Float) {
        position = new Point(x, y);

        merchandise = new List<Merchandise>();
    }

    public function getMerchandise(): List<Merchandise> {
        return merchandise;
    }

    public function dispense(merch: Merchandise): Merchandise {
        var correct = merchandise.remove(merch);

        if (correct) {
            return merch;
        }

        return null;
    }

    public function addItem(merch: Merchandise) {
        merchandise.add(merch);
    }

     function get_x(): Float {
        return position.x;
    }

    function get_y(): Float {
        return position.y;
    }
}