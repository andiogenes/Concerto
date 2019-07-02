package app;

import view.View;
import app.ConfigLoader;

class Application {
    private static final DATA_PATH = 'assets/data.json';

    public function new() {
        // Config loading
        var config = ConfigLoader.create(DATA_PATH).getConfig();

        // Model generation
        var builder = new ModelBuilder();
        new ModelDirector(config, builder).make();

        var model = builder.getModel();

        var view = View.create(model);
    }
}