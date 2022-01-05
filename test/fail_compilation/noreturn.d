/*
REQUIRED_ARGS: -w -o-

TEST_OUTPUT:
---
fail_compilation/noreturn.d(115): Error: `"Accessed expression of type `noreturn`"`
fail_compilation/noreturn.d(119):        called from here: `assign()`
fail_compilation/noreturn.d(126): Error: `"Accessed expression of type `noreturn`"`
fail_compilation/noreturn.d(126):        called from here: `foo(n)`
fail_compilation/noreturn.d(130):        called from here: `calling()`
fail_compilation/noreturn.d(136): Error: `"Accessed expression of type `noreturn`"`
fail_compilation/noreturn.d(139):        called from here: `nested()`
fail_compilation/noreturn.d(145): Error: cannot cast `i` of type `int` to noreturn type
fail_compilation/noreturn.d(146): Error: cannot cast `cast(double)i` of type `double` to noreturn type
fail_compilation/noreturn.d(155):        called from here: `casting(0)`
fail_compilation/noreturn.d(156): Error: CTFE failed because of previous errors in `casting`
fail_compilation/noreturn.d(157): Error: CTFE failed because of previous errors in `casting`
---

https://github.com/dlang/DIPs/blob/master/DIPs/accepted/DIP1034.md
*/

#line 100

alias noreturn = typeof(*null);

int pass()
{
    noreturn n;
    noreturn m;
    return 0;
}

enum forcePass = pass();

int assign()
{
    noreturn n;
    noreturn m = n;
    return 0;
}

enum forceAss = assign();

void foo(const noreturn) {}

int calling()
{
    noreturn n;
    foo(n);
    return 0;
}

enum forceCall = calling();

int nested()
{
    int[4] arr;
    noreturn n;
    return arr[n ? n : n];
}

enum forceNested = nested();

noreturn casting(int i)
{
    final switch (i)
    {
        case 0: return cast(noreturn) i;
        case 1: return cast(typeof(assert(0))) cast(double) i;
        case 2, 3: {
            noreturn n;
            return cast() n;
        }
    }
    assert(false);
}

enum forceCasting0 = casting(0);
enum forceCasting1 = casting(1);
enum forceCasting2 = casting(2);

/*
struct HasNoreturnStruct
{
    noreturn n;
}

int inStruct()
{
    HasNoreturnStruct hn;
    return hn.n;
}

enum forceInStruct = inStruct();

class HasNoreturnClass
{
    noreturn n;
}

int inClass()
{
    HasNoreturnClass hn = new HasNoreturnClass();
    return hn.n;
}

enum forceInClass = inClass();

int inClassRef()
{
    static void byRef(ref noreturn n) {}
    HasNoreturnClass hn = new HasNoreturnClass();
    byRef(hn.n);
    return 0;
}

enum forceInClassRef = inClassRef();
*/
