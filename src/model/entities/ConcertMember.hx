package model.entities;

import utils.Point;

class ConcertMember {
    public var objectType(default, null): String = "";

    private var position: Point;
    private var spawnPosition: Point;
    private var stage: Stage;

    public var x(get, set): Float;
    public var y(get, set): Float;
    public var isDisposed(default, null): Bool;

    private function new(x: Float, y: Float, ?stage: Stage) {
        position = new Point(x, y);
        spawnPosition = new Point(x, y);

        if (stage != null) {
            this.stage = stage;
        }

        isDisposed = false;
    }

    public function update() {}

    public function getStage(): Stage {
        return stage;
    }

    public function setStage(stage: Stage) {
        this.stage = stage;
    }

    public function dispose() {
        isDisposed = true;
    }

    public function getSpawnPosition(): Point {
        return spawnPosition;
    }

    function get_x(): Float {
        return position.x;
    }

    function set_x(_x: Float): Float {
        return position.x = _x;
    }

    function get_y(): Float {
        return position.y;
    }
    
    function set_y(_y: Float): Float {
        return position.y = _y;
    }
}