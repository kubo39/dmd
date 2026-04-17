/*
 * `.length` lowering for associative arrays should use template inference
 * for `_d_aaLen` instead of explicit template arguments, to avoid ambiguous
 * overload resolution between `inout` and `shared(const(...))` overloads.
 */
import std.json;

enum root = parseJSON(`{"a": 1, "b": 2}`).object();
static assert(is(typeof(root) == JSONValue[const(char)[]]));
static assert(cast(int) root.length == 2);
