/* MinWin Application structure
 *
 * An Application encapsulates the global state provided by
 * the OS when starting the application and it manages the event queue.
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.app;

private {
    import minwin.logging;
    import minwin.multidg;
    import minwin.event;
    import std.string;
}

version(MinWin32) {
    private import minwin.mswindows;
}

extern (C) void gc_init();
extern (C) void gc_term();
extern (C) void _minit();
extern (C) void _moduleCtor();
extern (C) void _moduleUnitTests();
extern (C) int MinWinMain(Application* app);

const int NO_ID = -1;
class MinWinException : Exception {
    int id = NO_ID;
    this(char[] msg) {
        super(msg);
    }
    this(char[] msg, int id) {
        this.id = id;
        if (id == NO_ID)
            super(msg);
        else
            super(format("%s (error code %x)",msg,id));
    }
}

// Assert a condition is true and if not throw an exception.
void sysAssert(bool passed, char[] msg, int id = 0) {
    if (!passed) {
        version (MinWin32) {
            if (GetVersion() < 0x80_00_00_00 || id != 0) {
                throw new MinWinException(msg,id);
            } else {
                throw new MinWinException(msg,GetLastError());
            }
        } else {
            throw new MinWinException(msg,id);
        }
    }
}

Application gApp;

version (MinWin32) {

    extern (Windows)
    void MinWinIdleProc(HWND hWnd, uint msg, uint id, DWORD time) {
        gApp.idleDelegate();
    }

    struct Application {

        char[] rsrc(char[] id, char[] group = "strings") {
            wchar[] wres;
            char[] cres;
            if (useWfuncs)
                wres.length = 64;
            else
                cres.length = 64;
            int len;
            for (;;) {
                if (useWfuncs) {
                    len = cast(int)LoadStringW(gApp.hInstance,toUTF16z(id),wres.ptr,wres.length);
                    if (len < wres.length) break;
                    else wres.length = 2*wres.length;
                }
                else {
                    len = cast(int)LoadStringA(gApp.hInstance,toMBSz(id),cres.ptr,cres.length);
                    if (len < cres.length) break;
                    else cres.length = 2*cres.length;
                }
            }
            if (useWfuncs)
                return toUTF8(wres[0..len]);
            else {
                return fromMBSz(cres[0..len].ptr);
            }
        }

        char[][] cmdLineArgs(){
            // TODO: parse cmd line args
            return parsedCmdLineArgs;
        }

        MultiDelegate!() idleDelegate;

        private uint fTimerID;
        private uint fIdleTime;
        uint idleTime() {
            return fIdleTime;
        }
        void idleTime(uint t) { // time 0 means stop
            fIdleTime = t;
            if (fTimerID) {
                BOOL ok = KillTimer(null,fTimerID);
                sysAssert(ok != false, "Failed to kill existing timer");
            }
            if (t) {
                fTimerID = SetTimer(null,0,t,&MinWinIdleProc);
                sysAssert(fTimerID != 0, "Failed to set timer");
            }
        }

        int enterEventLoop() {
            while (nextEvent(&event)) {
                // TODO: check IsDialogMessage
                dispatchEvent(&event);
            }
            return 1;
        }

        void exitEventLoop() {
            PostQuitMessage(0);
        }

        HINSTANCE hInstance;
        HINSTANCE hPrevInstance;
        LPSTR lpCmdLine;
        char[][] parsedCmdLineArgs;
        int nCmdShow;
        Event event;
    }

    extern (Windows)
    int WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
        int result;
        gc_init();          // initialize garbage collector
        _minit();           // initialize module constructor table

        try
        {
            _moduleCtor();      // call module constructors
            _moduleUnitTests(); // run unit tests (optional)

            gApp.hInstance = hInstance;
            gApp.hPrevInstance = hPrevInstance;
            gApp.nCmdShow = nCmdShow;
            version (LOG) log.writefln("about to enter MinWinMain");
            result = MinWinMain(&gApp);
            version (LOG) log.writefln("done with MinWinMain");
        }

        catch (Object o)        // catch any uncaught exceptions
        {
            MessageBoxX(null, o.toString(), "Error",MB_OK | MB_ICONEXCLAMATION);
            result = 0;     // failed
        }
        version(LOG) log.close();
        if (gApp.fTimerID) {
            BOOL ok = KillTimer(null,gApp.fTimerID);
            sysAssert(ok != false, "Failed to kill existing timer at exit");
        }
        gc_term();          // run finalizers; terminate garbage collector
        return result;
    }

} else version (GTK) {

    private {
        import minwin.gtk;
        import std.string;
        import std.file;
    }

    extern (C)
    gboolean MinWinIdleProc(gpointer data) {
        gApp.idleDelegate();
        return true;
    }

    struct Application {

        char[][] cmdLineArgs;

        char[] rsrc(char[] id, char[] group = "strings") {
            // TODO
            return "";
        }

        char[] resourcePath;

        int enterEventLoop() {
            gtk_main();
            return 1;
        }

        void exitEventLoop() {
            gtk_main_quit();
        }

        MultiDelegate!() idleDelegate;
        uint fIdleTime;
        uint idleTime() {
            return fIdleTime;
        }

        guint fTimerID;

        static
        void idleTime(uint t) {
            gApp.fIdleTime = t;
            if (gApp.fTimerID)
                g_source_remove(gApp.fTimerID);
            if (t)
                gApp.fTimerID = g_timeout_add(t,&MinWinIdleProc,null);
        }
    }

    int main(char[][] args) {
        gApp.cmdLineArgs = args;

        char*[] argv;
        argv.length = args.length;
        foreach (int n, char[] str; args) {
            argv[n] = toStringz(str);
        }
        int argc = args.length;
        char**argvp = argv.ptr;
        gtk_init(&argc,&argvp);

        int res = MinWinMain(&gApp);
        version(LOG) log.close();
        return res;
    }
}
