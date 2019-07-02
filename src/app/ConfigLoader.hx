package app;

typedef MusicianConfig = {
    var name: String;
    var tuneUp: Int;
    var songs: Array<{name: String, duration: Int}>;
} 

typedef AppConfig = {
    var width: Float;
    var height: Float;
    var minListeners: Int;
    var maxListeners: Int;
    var minListenerMoney: Int;
    var maxListenerMoney: Int;
    var store: {
        x: Float,
        y: Float,
        items: Array<{price: Int, quality: Int}>
    };
    var stage: {
        x: Float,
        y: Float,
        directionX: Float,
        directionY: Float,
        radius: Float,
        angle: Float,
        soundQuality: Int
    };
    var musicians: Array<MusicianConfig>;
}

class ConfigLoader {
    private var config: AppConfig = null;

    private function new(dataPath: String) {
        var data = load(dataPath);
        parse(data);
    }

    private function load(dataPath: String): String {
        return "";
    }

    private function parse(data: String) {
        try {
            var out = haxe.Json.parse(data);
            config = out;
        }
        catch (e: Dynamic) {
            config = null;
        }
    }

    public function getConfig(): AppConfig {
        return config;
    }

    public static function create(dataPath: String): ConfigLoader {
    #if concerto_js
        return new JSConfigLoader(dataPath);
    #elseif concerto_heaps
        return new DesktopConfigLoader(dataPath);
    #end
    }
}

class JSConfigLoader extends ConfigLoader {
    public function new(dataPath: String) {
        super(dataPath);
    }

#if concerto_js
    override function load(dataPath: String): String {
        var xhr = new js.html.XMLHttpRequest();
        xhr.open('GET', dataPath, false);
        xhr.send(null);

        if (xhr.status == 200) {
            return xhr.response;
        }

        return "";
    }
#end
}

class DesktopConfigLoader extends ConfigLoader {
    public function new(dataPath: String) {
        super(dataPath);
    }

#if !concerto_js
    override function load(dataPath:String): String {
        try {
            var content = sys.io.File.getContent(dataPath);
            return content;
        }
        catch (e: Dynamic) {
            return "";
        }
    }
#end
}