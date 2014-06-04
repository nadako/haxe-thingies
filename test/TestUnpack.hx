using Unpack;

class TestUnpack extends haxe.unit.TestCase {

    #if !macro
    function testArrayUnpack() {
        [1, 2].unpackInto(a, b);
        assertEquals(a, 1);
        assertEquals(b, 2);

        [a, b].unpackInto([b, a]);
        assertEquals(a, 2);
        assertEquals(b, 1);
    }

    function testStructUnpack() {
        var v = [{a: [1]}, {a: [2,3,4]}];
        v.unpackInto({a: [a]}, {a: {length: l}});
        assertEquals(a, 1);
        assertEquals(l, 3);
    }

    function testElementSkip() {
        var v = [1,2,3];
        v.unpackInto(a, _, b);
        assertEquals(a, 1);
        assertEquals(b, 3);
        assertEquals(typeError(_), "Unknown identifier : _");
    }

    function testInvalidUnpackExpr() {
        assertEquals(typeError([].unpackInto("hello")), "Unsupported unpack expression");
        assertEquals(typeError([].unpackInto(a | b)), "Unsupported unpack expression");
    }
    #end

    static macro function typeError(e) {
        return try {
            haxe.macro.Context.typeExpr(e);
            null;
        } catch(e:haxe.macro.Expr.Error) {
            return macro $v{e.message};
        }
    }
}
