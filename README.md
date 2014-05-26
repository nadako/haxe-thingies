# Haxe Thingies

This repo contains several useful little types and macros for Haxe that may or may not ease developer's life. See the code or unit tests to get the idea how and when to use these.

## DynamicObject

This type wraps `Reflect` field access for dynamic structures in a `Map`-like interface, making it easier to work with JSON or external JavaScript objects.

```haxe
var d:DynamicObject<Int> = haxe.Json.parse('{"item1": 1, "item2": 2}');
for (key in d.keys())
    trace(d[key]);
```

## OptionalField

This type provides explicit, but convenient syntax for working with optional and potentially missing structure fields, wrapping `Reflect.hasField` calls.

```haxe
var house:{?tennant:OptionalField<String>} = {};
var tennant = house.tennant.or("Ghosts");
```

## Yet to add
 * Const (https://gist.github.com/nadako/8999329)
 * CommandMacro (thing that generates runtime checks for command arguments type)
 * Type validator + JSON parser using haxe (http://nadako.tumblr.com/post/77106860013/using-haxe-macros-as-syntax-tolerant-position-aware)
