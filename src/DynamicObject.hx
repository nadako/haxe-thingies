/**
    DynamicObject is an abstract type for working with anonymous structures
    that are intended to hold collections of objects by the string key.

    These types of structures are often created by JSON objects.

    Basically, it wraps Reflect calls in a Map-like interface.
**/
abstract DynamicObject<T>(Dynamic<T>) from Dynamic<T> {

    /**
        Creates a new structure.
    **/
    public inline function new() this = {};

    /**
        Returns a value by specified `key`.

        If the structure does not contain the given key, null is returned.

        If `key` is null, the result is unspecified.
    **/
    @:arrayAccess
    public inline function get(key:String):Null<T> return Reflect.field(this, key);

    /**
        Sets a `value` for a specified `key`.

        If the structure contains the given key, its value will be overwritten.

        If `key` is null, the result is unspecified.
    **/
    @:arrayAccess
    public inline function set(key:String, value:T) Reflect.setField(this, key, value);

    /**
        Tells if the structure contains a specified `key`.

        If `key` is null, the result is unspecified.
    **/
    public inline function exists(key:String):Bool return Reflect.hasField(this, key);

    /**
        Removes a specified `key` from the structure.

        Returns true, if `key` was present in structure, or false otherwise.

        If `key` is null, the result is unspecified.
    **/
    public inline function remove(key:String):Bool return Reflect.deleteField(this, key);

    /**
        Returns an array of `keys` in a structure.
    **/
    public inline function keys():Array<String> return Reflect.fields(this);
}
