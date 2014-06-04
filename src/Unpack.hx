import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ExprTools;

@:dce // don't generate anything
class Unpack {

    public static macro function unpackInto(object:Expr, pattern:Expr, rest:Array<Expr>):Expr {
        // allow easy syntax for array unpacking
        if (rest.length > 0)
            pattern = macro @:pos(pattern.pos) $a{[pattern].concat(rest)};

        var vars = [];
        var unpackExpr = unpackRec(object, pattern, vars);

        var result = [for (name in vars) macro var $name];
        result.push(unpackExpr);

        return macro @:mergeBlock $b{result};
    }

    #if macro
    static function unpackRec(object:Expr, pattern:Expr, vars:Array<String>):Expr {
        var result = [];

        function capture(valueExpr:Expr, captureExpr:Expr) {
            switch (captureExpr) {
                case macro $i{name}:
                    if (name == "_")
                        return;
                    vars.push(name);
                    result.push(macro $i{name} = $valueExpr);
                default:
                    result.push(unpackRec(valueExpr, captureExpr, vars));
            }
        }

        switch (pattern.expr) {
            case EArrayDecl(values):
                var i = 0;
                for (v in values)
                    capture(macro tmp[$v{i++}], v);

            case EObjectDecl(fields):
                for (f in fields) {
                    var fieldName = f.field;
                    capture(macro tmp.$fieldName, f.expr);
                }

            default:
                throw new Error("Unsupported unpack expression", pattern.pos);
        }

        if (result.length > 0)
            result.unshift(macro var tmp = $object);

        return macro $b{result};
    }
    #end
}
