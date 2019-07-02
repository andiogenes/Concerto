package view;

interface Image {
    public function draw(x: Float, y: Float, ?width: Float, ?height: Float): Void;
}

#if concerto_js
class JSImage implements Image {
    private var context: js.html.CanvasRenderingContext2D;
    private var concreteImage: js.html.Image;

    public function new(path: String, context: js.html.CanvasRenderingContext2D) {
        this.context = context;

        concreteImage = new js.html.Image();
        concreteImage.src = path;
    }

    public function draw(x: Float, y: Float, ?width: Float, ?height: Float) {
        if (width == null || height == null) {
            context.drawImage(concreteImage, x - concreteImage.width/2, y - concreteImage.height/2);
        } else {
            context.drawImage(concreteImage, x - width/2, y - height/2, width, height);
        }
    }
}
#end

#if concerto_heaps
class HeapsImage implements Image {
    public function new(path: String, g: h2d.Graphics) {
        throw "Error: unimplemented class HeapsImage";
    }

    public function draw(x: Float, y: Float, ?width: Float, ?height: Float) {
        throw "Error: unimplemented method drawImage";
    }
}
#end