/* MinWin Dialog class
 *
 * A general dialog class and utility helper dialogs
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.dialog;

private {
    import std.string;
    import std.c.string;
    import minwin.peerimpl;
    import minwin.font;
    import minwin.event;
    import minwin.component;
    import minwin.menu;
    import minwin.app;
    import minwin.logging;
    import minwin.icon;
    import minwin.image;
}

version (MinWin32) {

    private import minwin.mswindows;

    class Dialog : AbstractWindow {
        AbstractWindow owner;
        bool modal_data;
        bool visible_data;

        this(AbstractWindow owner, char[] title = "", bool modal = true, char[] name = "") {
            Rect r;
            owner.getBounds(r);
            DWORD style = WS_TABSTOP | WS_POPUP | DS_MODALFRAME | WS_CAPTION | WS_SYSMENU;
            peer = CreateWindowX("MinWinDialog", title,
                 style & ~WS_MAXIMIZEBOX & ~WS_MINIMIZEBOX,
                 r.left, r.top,
                 DefaultWindowWidth, DefaultWindowHeight,
                 owner.peer,
                 cast(HMENU) null, gApp.hInstance, null);
            sysAssert(peer !is null, "Failed to create peer Dialog");
            setWindowPeer(this,peer,OWNS_PEER);
            backgroundPeer = CreateSolidBrush(systemBackgroundColor().native);
            this.name = name;
            this.owner = owner;
            modal_data = modal;
            WindowList[this] = this; // prevent garbage collection
        }

        this(WindowPeer peer) {
            setWindowPeer(this,peer,FOREIGN_PEER);
            WindowList[this] = this; // prevent garbage collection
        }

        AbstractWindow[] originalWindows;
        int[] originalEnabledState;

        void visible(bool vis) {
            if (modal_data && !vis && visible_data) {
                // make sure original states are restored before hiding
                foreach(int n, AbstractWindow w; originalWindows) {
                    if (IsWindow(w.peer)) {
                        EnableWindow(w.peer,originalEnabledState[n]);
                    }
                }
                originalWindows = null;
                originalEnabledState = null;
            }
            version (LOG) log.writefln("setting dialog visible %d",cast(int)vis);
            super.visible(vis);
            version (LOG) log.writefln("done with super vis");
            visible_data = vis;
            if (modal_data && vis) {
                cancelCloseDelegate ~= delegate bool(Component c) {
                    Dialog dlg = cast(Dialog)c;
                    if (!dlg || !dlg.owner) return false;
                    EnableWindow(dlg.owner.peer,1);
                    return false;
                };
                version (LOG) log.writefln("disabling windows dialog");
                originalWindows = WindowList.values;
                originalEnabledState.length = originalWindows.length;
                foreach(int n, AbstractWindow w; originalWindows) {
                    originalEnabledState[n] = IsWindowEnabled(w.peer) != 0;
                    version (LOG) log.writefln("disable %d %p for dialog",n,w);
                    if (originalEnabledState[n] != 0 && (w !is this)) {
                        EnableWindow(w.peer,0);
                    }
                }
                while (visible_data && IsWindow(peer)) {
                    version (LOG) log.writefln("in modal loop for %p",this);
                    if (!GetMessageA(&gApp.event.native, cast(HWND) null, 0, 0)) {
                        PostQuitMessage(0); // quit out of next event loop
                        break;
                    }
                    if (!IsDialogMessageA(peer, &gApp.event.native)) {
                        TranslateMessage(&gApp.event.native);
                        DispatchMessageA(&gApp.event.native);
                    }
                }
                visible_data = false;
                foreach(int n, AbstractWindow w; originalWindows) {
                    if (IsWindow(w.peer)) {
                        EnableWindow(w.peer,originalEnabledState[n]);
                    }
                }
            }
        }

        int WindowProc(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam) {
            bool doDefault = true;
            if (uMsg <= WM_KEYLAST && uMsg >= WM_KEYFIRST) {
                keyDelegate(this,cast(KeyEvent*)&gApp.event);
            } else if (uMsg <= WM_MOUSELAST && uMsg >= WM_MOUSEFIRST) {
                mouseDelegate(this,cast(MouseEvent*)&gApp.event);
            } else {
                doDefault = super.WindowProc(hWnd,uMsg,wParam,lParam) != 0;
            }
            return doDefault;
        }
        // also handle tab key by calling GetNextDlgTabItem
    }
    static this() {
        if (DefaultWindowIcon is null) {
            IconPeer ip = LoadIconA(cast(HINSTANCE) null, IDI_APPLICATION);
            DefaultWindowIcon = DefaultWindowSmallIcon = new Icon(ip);
        }
        HINSTANCE hInst = GetModuleHandleA(null);
        WNDCLASSA wc;
        wc.lpszClassName = "MinWinDialog";
        wc.style = CS_OWNDC | CS_HREDRAW | CS_VREDRAW;
        wc.lpfnWndProc = &MinWinWindowProc;
        wc.hInstance = hInst;
        wc.hIcon = DefaultWindowIcon.peer;
        wc.hCursor = LoadCursorA(cast(HINSTANCE) null, IDC_ARROW);
        wc.hbrBackground = null;
        //        wc.hbrBackground = cast(HBRUSH) (COLOR_WINDOW); // not +1 for default
        wc.lpszMenuName = null;
        wc.cbClsExtra = 0;
        wc.cbWndExtra = 0;
        RegisterClassA(&wc);
    }

} else version (GTK) {

    private import minwin.gtk;
    private import minwin.gtk_peers;

    class Dialog : AbstractWindow {
        AbstractWindow owner;

        this(AbstractWindow owner, char[] title = "", bool modal = true, char[] name = "") {
            char* str = toStringz(title);
            this.owner = owner;
            // TODO: application name vs window name??
            peer = cast(GtkWindow*)gtk_window_new(GtkWindowType.GTK_WINDOW_TOPLEVEL);
            if (modal) {
                gtk_window_set_modal(peer,modal);
                gtk_window_set_transient_for(peer,owner.peer);
            }
            gtk_window_set_title(peer,str);
            gtk_window_set_resizable(peer,0);
            gtk_window_set_default_size(peer,DefaultWindowWidth,DefaultWindowHeight);
            this.name = name;
            g_signal_connect_data(peer,"destroy",
                    cast(GCallback)&mw_destroy_callback,
                    cast(gpointer)this,
                    null,cast(GConnectFlags)0);
            g_signal_connect_data(peer,"delete-event",
                    cast(GCallback)&mw_dialog_close_callback,
                    cast(gpointer)this,
                    null,cast(GConnectFlags)0);
            setWindowPeer(this,peer,OWNS_PEER);
            WindowList[this] = this; // prevent garbage collection

            content = cast(MinWinGtkPeer*)MinWinGtkPeer_new();
            GtkWidget* wcontent = cast(GtkWidget*)content;
            gtk_widget_set_sensitive(wcontent,true);
            content.sizeRequest = &gtkRequest;
            content.sizeAllocate = &gtkAllocate;
            gtk_container_add(cast(GtkContainer*)peer,wcontent);
            g_signal_connect_data(peer,"expose-event",
                    cast(GCallback)&mw_expose_callback,
                    cast(gpointer)this,
                    null,GConnectFlags.G_CONNECT_AFTER);
            gtk_widget_realize(wcontent);
            gtk_widget_show(wcontent);
        }

        this(AbstractWindow owner, WindowPeer peer) {
            setWindowPeer(this,peer,FOREIGN_PEER);
            this.owner = owner;
            WindowList[this] = this; // prevent garbage collection
        }

        GMainLoop* loop;

        void visible(bool vis) {
            version(LOG)log.writefln("calling super.visible %d",vis);
            version(LOG)log.flush();
            super.visible(vis);
            version(LOG)log.writefln("done calling super.visible %d",vis);
            version(LOG)log.flush();
            if (!gtk_window_get_modal(peer)) return;
            if (vis) {
                version(LOG)log.writefln("making event loop");
                version(LOG)log.flush();
                loop = g_main_loop_new(null, false);
                g_main_loop_run(loop);
                g_main_loop_unref(loop);
                        version(LOG)log.writefln("exiting event loop");
                        version(LOG)log.flush();
                // that's it?
            } else {
                if (g_main_loop_is_running(loop))
                    g_main_loop_quit(loop);
                version(LOG)log.writefln("visible off quit loop event loop");
                version(LOG)log.flush();
            }
        }
    }
    extern (C) void mw_dialog_close_callback(GtkWidget* w, GdkEvent* ev, gpointer ud) {
        AbstractWindow win = cast(AbstractWindow) ud;
        version(LOG)log.printf("mw_dialog_close_callback\n");
        if (win) {
            win.visible = false;
            //            win.close(); // destroys dialog so dont do this
        }
    }
}


/***************************************
                         Helper dialogs
***************************************/

// used in open and save file dialogs for filtering
struct FileFilter {
    char[] description;
    char[][] extensions;
}
version (GTK) {
    version = SharedFileDialogData;
}

version (SharedFileDialogData) {
    struct FileDialogData {
        char[] title;
        FileFilter[] filter;
        char[] initialDir;
        char[] initialFile;
        char[] result;
        int filterIndex;
        int done;

        // can get the requested buffer length...
        bool isBufferTooShort() {
            return false; // TODO
        }
    }
}

version (MinWin32) {
    private {
        import minwin.mswindows;
        import std.c.stdlib;
    }

    void informationDialog(AbstractWindow owner, char[] text, char[] title) {
     //version(LOG) log.writefln("info dialog peer is %x",cast(uint)owner.peer);
        MessageBoxX(owner.peer, text, title, MB_OK | MB_ICONINFORMATION);
    }
    void warningDialog(AbstractWindow owner, char[] text, char[] title) {
        MessageBoxX(owner.peer, text, title, MB_OK | MB_ICONWARNING);
    }
    void errorDialog(AbstractWindow owner, char[] text, char[] title) {
        MessageBoxX(owner.peer, text, title, MB_OK | MB_ICONERROR);
    }
    void messageDialog(AbstractWindow owner, char[] text, char[] title,...) {
        MessageBoxX(owner.peer, text, title, MB_OK | MB_ICONINFORMATION);
    }

    alias OPENFILENAMEA FileDialogNative;
    struct FileDialogData {
        FileDialogNative native;

        void title(char[] title) {
            native.lpstrTitle = toStringz(title);
        }
        char[] title() {
            return native.lpstrTitle[0 .. strlen(native.lpstrTitle)];
        }

        void filter(FileFilter[] filters) {
            char[] total;
            foreach (FileFilter f; filters) {
                total ~= f.description;
                total ~= 0;
                if (f.extensions.length > 0) {
                    foreach (char[] ext; f.extensions) {
                        total ~= "*.";
                        total ~= ext;
                        total ~= ";";
                    }
                    total.length = total.length - 1; // remove last ;
                }
                total ~= 0;
            }
            total ~= 0;
            total ~= 0;
            native.lpstrFilter = total.ptr;
        }

        void initialDir(char[] initialDir) {
            native.lpstrInitialDir = toStringz(initialDir);
        }

        void initialFile(char[] f) {
            if (native.lpstrFile is null) {
                native.lpstrFile = (new char[MAX_PATH]).ptr;
                native.nMaxFile = MAX_PATH;
            }
            int len = f.length < native.nMaxFile-1 ? f.length : native.nMaxFile-1;
            native.lpstrFile[0 .. len] = f[0 .. len];
            native.lpstrFile[len] = 0;
        }

        char[] result() {
            return native.lpstrFile[0 .. strlen(native.lpstrFile)];
        }

        // can get the requested buffer length...
        bool isBufferTooShort() {
            //        bool res = CommDlgExtendedError() == FNERR_BUFFERTOOSMALL;
            return false;
        }

        int filterIndex() {
            return native.nFilterIndex;
        }

    }

    bool openFileDialog(AbstractWindow owner, inout FileDialogData data) {
        data.native.hwndOwner = owner.peer;
        data.native.lStructSize = OPENFILENAMEA.sizeof;
        //        data.flags = OFN_OVERWRITEPROMPT | OFN_PATHMUSTEXIST;
        data.native.Flags = OFN_PATHMUSTEXIST;
        if (data.native.lpstrFile is null) {
            data.native.lpstrFile = (new char[MAX_PATH]).ptr;
            data.native.nMaxFile = MAX_PATH;
            data.native.lpstrFile[0] = 0;
        }
        bool res = GetOpenFileNameA(&data.native) != 0;
        /*        if (!res)
         check if the name was too long for the buffer
        */
        return res;
    }

    bool saveFileDialog(AbstractWindow owner, inout FileDialogData data) {
        data.native.hwndOwner = owner.peer;
        data.native.lStructSize = OPENFILENAMEA.sizeof;
        data.native.Flags = OFN_OVERWRITEPROMPT | OFN_PATHMUSTEXIST;
        if (data.native.lpstrFile is null) {
            data.native.lpstrFile = (new char[MAX_PATH]).ptr;
            data.native.nMaxFile = MAX_PATH;
            data.native.lpstrFile[0] = 0;
        }
        bool res = GetSaveFileNameA(&data.native) != 0;
        /*        if (!res)
         check if the name was too long for the buffer
        */
        return res;
    }

} else version(GTK) {

    private import minwin.gtk;
    private import minwin.window;

    void informationDialog(AbstractWindow owner, char* text, char[] 
title) {
        msgDialog(owner,text,title,GtkMessageType.GTK_MESSAGE_INFO,
                GtkButtonsType.GTK_BUTTONS_OK);
    }
    void warningDialog(AbstractWindow owner, char* text, char[] title) {
        msgDialog(owner,text,title,GtkMessageType.GTK_MESSAGE_WARNING,
                GtkButtonsType.GTK_BUTTONS_OK);
    }
    void errorDialog(AbstractWindow owner, char* text, char[] title) {
        msgDialog(owner,text,title,GtkMessageType.GTK_MESSAGE_ERROR,
                GtkButtonsType.GTK_BUTTONS_OK);
    }
    alias informationDialog messageDialog;
    void msgDialog(AbstractWindow owner, char* text, char[] title,
         GtkMessageType type, GtkButtonsType buttons) {
        // TODO: title?
        GtkWidget* d = gtk_message_dialog_new(owner.peer,
                        GtkDialogFlags.GTK_DIALOG_DESTROY_WITH_PARENT,
                        type,buttons,text);
        gtk_dialog_run(cast(GtkDialog*)d);
        gtk_widget_destroy(d);
    }

    bool openFileDialog(AbstractWindow owner, inout FileDialogData data) {
        bool result;
        GtkWidget* peer =
            gtk_file_chooser_dialog_new(toStringz(data.title),owner.peer,
                    GtkFileChooserAction.GTK_FILE_CHOOSER_ACTION_OPEN,
        cast(char*)"gtk-cancel", cast(uint)GtkResponseType.GTK_RESPONSE_CANCEL,
        cast(char*)"gtk-open", cast(uint)GtkResponseType.GTK_RESPONSE_ACCEPT,
                    null);
        GtkFileChooser* fc = cast(GtkFileChooser*)peer;
        return opensaveFileDialog(data,peer,fc);
    }

    bool saveFileDialog(AbstractWindow owner, inout FileDialogData data) {
        GtkWidget* peer =
            gtk_file_chooser_dialog_new(toStringz(data.title),owner.peer,
                    GtkFileChooserAction.GTK_FILE_CHOOSER_ACTION_SAVE,
        cast(char*)"gtk-cancel", cast(uint)GtkResponseType.GTK_RESPONSE_CANCEL,
        cast(char*)"gtk-save", cast(uint)GtkResponseType.GTK_RESPONSE_ACCEPT,
                    null);
        GtkFileChooser* fc = cast(GtkFileChooser*)peer;
        if (data.initialFile.length > 0)
            gtk_file_chooser_set_current_name(fc,toStringz(data.initialFile));
        return opensaveFileDialog(data,peer,fc);
    }
    bool opensaveFileDialog(inout FileDialogData data,
                GtkWidget* peer,
                GtkFileChooser* fc) {
        bool result;
        if (data.initialDir.length > 0)
            gtk_file_chooser_set_current_folder(fc,toStringz(data.initialDir));
        foreach( FileFilter filt ; data.filter) {
            GtkFileFilter* f = gtk_file_filter_new();
            gtk_file_filter_set_name(f,toStringz(filt.description));
            foreach( char[] ext; filt.extensions) {
                gtk_file_filter_add_pattern(f,cast(char*)("*."~ext));
            }
            gtk_file_chooser_add_filter(fc,f);
        }
        // TODO: assertion local_full_path[0] = /
        result = gtk_dialog_run(cast(GtkDialog*)peer) == GtkResponseType.GTK_RESPONSE_ACCEPT;
        if (result) {
            char* name = gtk_file_chooser_get_filename(fc);
            int len = strlen(name);
            data.result = name[0..len].dup;
            g_free(name);
        }
        gtk_widget_destroy(peer);
        return result;
    }
}

// utility dialogs:
//     query dialog
//     file chooser dialog

//     color chooser?
//     print dialog?


