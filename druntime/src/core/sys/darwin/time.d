//Written in the D programming language

/++
    D header file for Darwin extensions to POSIX's time.h.

    Copyright: Copyright 2025
    License:   $(HTTP www.boost.org/LICENSE_1_0.txt, Boost License 1.0).
 +/
module core.sys.darwin.time;

version (OSX)
    version = Darwin;
else version (iOS)
    version = Darwin;
else version (TVOS)
    version = Darwin;
else version (WatchOS)
    version = Darwin;

version (Darwin):
extern(C):
nothrow:
@nogc:

enum CLOCK_UPTIME_RAW = 8;
