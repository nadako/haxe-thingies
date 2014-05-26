class TestOptionalField extends haxe.unit.TestCase {
    function testOptionalField() {
        var o:{?f:OptionalField<Int>} = {};
        assertFalse(o.f.exists());
        assertEquals(o.f.or(10), 10);
        o.f = null;
        assertTrue(o.f.exists());
        assertEquals(o.f.or(10), null);
        assertEquals(o.f.extract(), null);
        o.f = 15;
        assertTrue(o.f.exists());
        assertEquals(o.f.or(10), 15);
        assertEquals(o.f.extract(), 15);
    }
}
