class TestMain {
    static function main() {
        var runner = new haxe.unit.TestRunner();
        runner.add(new TestDynamicObject());
        runner.run();
    }
}