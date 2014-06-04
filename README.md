# Haxe Thingies

This repo contains several useful little types and macros for Haxe that may or may not ease developer's life. See the code or unit tests to get the idea how and when to use these.

## DynamicObject

This type wraps `Reflect` field access for dynamic structures in a `Map`-like interface, making it easier to work with JSON or external JavaScript objects.

```haxe
var d:DynamicObject<Int> = haxe.Json.parse('{"item1": 1, "item2": 2}');
for (key in d.keys())
    trace(d[key]);
```

is equivalent to

```haxe
for (key in Reflect.fields(d))
    trace((Reflect.field(d, key) : Int));
```


## OptionalField

This type provides explicit, but convenient syntax for working with optional and potentially missing structure fields, wrapping `Reflect.hasField` calls.

```haxe
var house:{?tennant:OptionalField<String>} = {};
var tennant = house.tennant.or("Ghosts");
```

is equvalent to

```haxe
var tennant = Reflect.hasField(house, "tennant") ? house.tennant : "Ghosts";
```

## Unpack

This is a using-macro implementing CoffeeScript-like value destructuring (http://coffeescript.org/#destructuring).

```haxe
var value = [{f: [1, 2, 3]}, {f: [1]}, {f: [1]}, {f: []}];
value.unpackInto({f: v1}, {f: [v2]}, _, {f: {length: v3}});
```

This unpacks arrays and object fields into local variables similar to pattern-matching, but with shorter syntax.
In the example above, there will be 3 variables generated: v1, capturing [1, 2, 3], v2 capturing 1 and v3 capturing 0.


## Yet to add
 * Const (https://gist.github.com/nadako/9200026)
 * CommandMacro (https://gist.github.com/nadako/7fd2372342d814ceabd5)
 * Type validator + JSON parser using haxe (http://nadako.tumblr.com/post/77106860013/using-haxe-macros-as-syntax-tolerant-position-aware)
