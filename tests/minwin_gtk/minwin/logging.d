module minwin.logging;

public import std.stream;

//version=StdOutLog;

version (LOG) {
    Stream log;
    version (StdOutLog) {
        static this() {
            log = stdout;
        }
    } else {
        static this() {
            log = new BufferedFile("log.txt",FileMode.OutNew);
        }
    }
}

