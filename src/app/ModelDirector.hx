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
            builder.setMusicianData(i * 45, 35, v.name, v.tuneUp);
            for (s in v.songs) {
                builder.addSongToList(s.name, s.duration, s.quality);
            }
            builder.addMusician();

            i++;
        }

        var listenersCount = utils.Random.randomize(config.minListeners, config.maxListeners);
        for (i in 0...listenersCount) {
            var x = if (Math.random() > 0.5) 0 else config.width;
            var y = if (Math.random() > 0.5) 0 else config.height;
            builder.addListener(
                x + Math.random() * 128 - 64, 
                y + Math.random() * 128 - 64,
                40,
                utils.Random.randomize(config.minListenerMoney, config.maxListenerMoney)
            );
        }
    }
}