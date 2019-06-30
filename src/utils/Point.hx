package utils;

class Point {
    public var x(default, set): Float;
    public var y(default, set): Float;

    public function new(x: Float, y: Float) {
        this.x = x;
        this.y = y;
    }

    function set_x(_x: Float) {
        return x = _x;
    }

    function set_y(_y: Float) {
        return y = _y;
    }
}