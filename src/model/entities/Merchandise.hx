package model.entities;

class Merchandise {
    public var price(default, set): Int = 0;
    public var quality(default, set): Int = 0;

    public function new(price: Int, quality: Int) {
        this.price = price;
        this.quality = quality;
    }
    
    function set_price(_price: Int): Int {
        if (_price >= 0) {
            price = _price;
        }

        return price;
    }

    function set_quality(_quality: Int): Int {
        if (_quality >= 0) {
            quality = _quality;
        }

        return quality;
    }
}