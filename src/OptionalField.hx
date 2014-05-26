import haxe.macro.Context;
import haxe.macro.Expr;

/**
    OptionalField is an abstract type for handling structure fields
    that can be missing, wrapping Reflect.hasField calls in an explicit
    but convenient way.
**/
abstract OptionalField<T>(T) from T
{
    /**
        Unsafe value extraction function. This should be only used
        after `exists` check or whenever you are sure that the field
        value exists.
    **/
    @:extern
    public inline function extract():T return this;
 
    /**
        Check if field is set. Basically this generates a Reflect.hasField call.
    **/
    public macro function exists(ethis:Expr):ExprOf<Bool>
    {
        return makeCheckExpr(ethis);
    }
 
    /**
        Return a field value, if it's set, or the default value otherwise.
        
        Generates a "Reflect.hasField(o, field) ? o.field : defaultValue"
        expression, so the defaultValue will only be evaluated if there's
        no field present.
    **/
    public macro function or(ethis:Expr, defaultValue:ExprOf<T>):ExprOf<T>
    {
        var check = makeCheckExpr(ethis);
        return macro $check ? $ethis.extract() : $defaultValue;
    }
 
    #if macro
    static function makeCheckExpr(ethis:Expr):ExprOf<Bool>
    {
        var typed = Context.typeExpr(ethis);
        switch (typed.expr)
        {
            case TField(e, FAnon(_.get() => f)) if (f.meta.has(":optional")):
                var eobj = Context.getTypedExpr(e);
                return macro Reflect.hasField($eobj, $v{f.name});
            default:
                throw new Error("OptionalField type is only usable for optional structure fields", ethis.pos);
        }
    }
    #end
}
