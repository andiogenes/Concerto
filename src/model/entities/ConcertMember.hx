package model.entities;

import utils.Point;

class ConcertMember {
    private var position: Point;
    private var stage: Stage;

    public var x(get, null): Float;
    public var y(get, null): Float;

    private function new(x: Float, y: Float, ?stage: Stage) {
        position = new Point(x, y);

        if (stage != null) {
            this.stage = stage;
        }
    }

    public function update() {}

    public function getStage(): Stage {
        return stage;
    }

    public function setStage(stage: Stage) {
        this.stage = stage;
    }

    function get_x(): Float {
        return position.x;
    }

    function get_y(): Float {
        return position.y;
    }
}