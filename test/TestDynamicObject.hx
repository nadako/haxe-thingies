class TestDynamicObject extends haxe.unit.TestCase {
    function testDynamicObject() {
        var d = new DynamicObject();
        assertFalse(d.exists("foo"));
        assertEquals(d.get("foo"), null);

        d.set("foo", 1);
        d.set("bar", 2);
        d["baz"] = 3;

        assertTrue(d.exists("foo"));
        assertTrue(d.exists("bar"));
        assertTrue(d.exists("baz"));

        assertEquals(d.get("foo"), 1);
        assertEquals(d.get("bar"), 2);
        assertEquals(d["baz"], 3);

        var keys = ["foo", "bar", "baz"];
        for (key in d.keys())
            assertTrue(keys.remove(key));
        assertEquals(keys.length, 0);

        assertTrue(d.remove("bar"));
        assertFalse(d.remove("bar"));
        assertTrue(d.exists("foo"));
        assertFalse(d.exists("bar"));
        assertTrue(d.exists("baz"));
        assertEquals(d.get("bar"), null);

        var d2:DynamicObject<Int> = {k: 5};
        assertEquals(d2["k"], 5);
    }
}
