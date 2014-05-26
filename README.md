# Haxe Thingies

This repo contains several useful little types and macros for Haxe that may or may not ease developer's life. See the code or unit tests to get the idea how and when to use these.

## DynamicObject

This type wraps `Reflect` field access for dynamic structures in a `Map`-like interface, making it easier to work with JSON or external JavaScript objects.

## OptionalField

This type provides explicit, but convenient syntax for working with optional and potentially missing structure fields, wrapping `Reflect.hasField` calls.
