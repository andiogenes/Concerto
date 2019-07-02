import app.Application;
class Main {
	static function main() {
		try {
			var app = new Application();
		}
		catch (e: Dynamic) {
			trace(Std.string(e));
		}
	}
}
