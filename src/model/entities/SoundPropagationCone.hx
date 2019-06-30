package model.entities;

import utils.Point;

class SoundPropagationCone {
    private var direction: Point;
    
    public var radius(default, set): Float = 0;
    public var angle(default, set): Float = 0;

    public function new(radius: Float, angle: Float, direction: Point) {
        this.radius = radius;
        this.angle = angle;
        this.direction = direction;
    }

    public function getDirection(): Point {
        return new Point(direction.x, direction.y);
    }

    public function setDirection(direction: Point) {
        this.direction = direction;
    }

    function set_radius(_radius: Float): Float {
        if (_radius >= 0) {
            radius = _radius;
        }

        return radius;
    }

    function set_angle(_angle: Float): Float {
        if (_angle >= 0 && _angle < Math.PI) {
            angle = _angle;
        }

        return angle;
    }
}