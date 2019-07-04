package app;

import app.ConfigLoader.AppConfig;

class ModelDirector {
    private var config: AppConfig;
    private var builder: ModelBuilder;

    public function new(config: AppConfig, builder: ModelBuilder) {
        this.config = config;
        this.builder = builder;
    }

    public function make() {
        builder.setSize(config.width, config.height);
            
        builder.setStorePosition(config.store.x, config.store.y);
        for (v in config.store.items) {
            builder.addItemToStore(v.price, v.quality);
        }

        builder
            .setStagePosition(config.stage.x, config.stage.y)
            .setConeRadius(config.stage.radius)
            .setConeAngle(config.stage.angle)
            .setConeDirection(config.stage.directionX, config.stage.directionY)
            .setSoundQuality(config.stage.soundQuality);

        var i = 1;
        for (v in config.musicians) {
            var x = i * 45;
            var y = 35;

            builder.setMusicianData(x, y, v.name, v.tuneUp);
            for (s in v.songs) {
                builder.addSongToList(s.name, s.duration, s.quality);
            }
            builder.addMusician();

            i++;
        }

        var listenersCount = utils.Random.randomize(config.minListeners, config.maxListeners);
        for (i in 0...listenersCount) {
            var isVerticalArrangement = Math.random() > 0.5;

            var x = if (isVerticalArrangement) {
                if (Math.random() > 0.5) 0 else config.width;
            } else {
                utils.Random.randomizeF(0, config.width);
            }

            var y = if (isVerticalArrangement) {
                utils.Random.randomizeF(0, config.height);
            } else {
                if (Math.random() > 0.5) 0 else config.height;
            }

            var mood = 40;
            var money = utils.Random.randomize(config.minListenerMoney, config.maxListenerMoney);
            
            builder.addListener(
                x + Math.random() * 128 - 64, 
                y + Math.random() * 128 - 64,
                mood,
                money
            );
        }
    }
}