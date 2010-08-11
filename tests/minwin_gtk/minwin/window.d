/* MinWin Window class
 *
 * An AbstractWindow is a top-level window. Concrete subclasses
 * are Window and Dialog.
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.window;

private {
    import std.string;
    import std.c.string;
    import minwin.peerimpl;
    import minwin.font;
    import minwin.event;
    import minwin.component;
    import minwin.menu;
    import minwin.app;
    import minwin.paint;
    import minwin.logging;
    import minwin.icon;
    import minwin.image;
}

int DefaultWindowWidth = 400;
int DefaultWindowHeight = 300;
Icon DefaultWindowIcon;
Icon DefaultWindowSmallIcon;

version (MinWin32) {
    public import std.utf : toUTF16z, toUTF16, toUTF8;
}

template CommonEventSourceImpl() {
    version (MinWin32) {
        HBRUSH backgroundPeer;
        void repaintNow() {
            UpdateWindow(peer);
        }

        GContext getGContext() {
            GContext gc = newGContext();
            gc.peer = GetDC(peer);
            sysAssert(gc.peer !is null, "Failed to get DC in getGContext");
            gc.hasPeer = OWNS_PEER;
            gc.release = true;
            gc.hwnd = peer;
            return gc;
        }

        Image getCompatibleImage(int width, int height) {
            HDC dc = GetDC(peer);
            sysAssert(dc !is null, "Failed to get DC in getCompatibleImage");
            ImagePeer bm = CreateCompatibleBitmap(dc,width,height);
            sysAssert(bm !is null, "Failed to create compatible bitmap");
            version(LOG) log.writefln("create bitmap %x",cast(int)bm);
            Image res = new Image(bm);
            res.width = width;
            res.height = height;
            res.hasPeer = OWNS_PEER;
            ReleaseDC(peer,dc);
            return res;
        }

        Image loadCompatibleImage(char[] imageKey, char[] fmt = "bmp") {
            // TODO: use fmt
            ImagePeer bm;
            if (useWfuncs)
                bm = LoadImageW(gApp.hInstance,toUTF16z(imageKey),IMAGE_BITMAP,0,0,0);
            else
                bm = LoadImageA(gApp.hInstance,toMBSz(imageKey),IMAGE_BITMAP,0,0,0);
            sysAssert(bm !is null, format("Failed to load image %s",imageKey));
            BITMAP bm_data;
            int ok = GetObjectA(bm,bm_data.sizeof,&bm_data);
            sysAssert(ok != false, "Failed to get bitmap data in loadCompatibleImage");
            version(LOG) log.writefln("create bitmap %x",cast(int)bm);
            Image res = new Image(bm);
            res.width = bm_data.bmWidth;
            res.height = bm_data.bmHeight;
            res.hasPeer = OWNS_PEER;
            return res;
        }

    } else version (GTK) {
        void repaintNow(Event* paintEvent = null) {
            layout(true);
            if (!paintDelegate.isEmpty) {
                GContext gc = getGContext(paintEvent);
                paintDelegate(this,gc);
                gc.dispose();
            }
        }
    }
}

template CommonWindowImpl() {
    static AbstractWindow[AbstractWindow] WindowList;
    bool quitOnDestroy;

    void doCommand(int cmd) {
        commandDelegate(this,cmd);
    }

    MultiDelegate!(Component, GContext) paintDelegate;
    MultiDelegate!(Component, GXContext) paintXDelegate;
    MultiDelegate!(Component, int) commandDelegate;
    MultiBoolDelegate!(Component) cancelCloseDelegate; // don't quit if bool is true

    // events
    MultiDelegate!(Component, KeyEvent*) keyDelegate;
    MultiDelegate!(Component, MouseEvent*) mouseDelegate;
    MultiDelegate!(Component, WindowEvent*) windowDelegate;

    Point preferredSize() {
        Point s;
        if (layoutMgr) {
            s = layoutMgr.preferredSize(this);
        } else {
            s.x = DefaultWindowWidth;
            s.y = DefaultWindowHeight;
        }
        if (userPreferredWidth > 0)
            s.x = userPreferredWidth;
        if (userPreferredHeight > 0)
            s.y = userPreferredHeight;
        return s;
    }
}

version (MinWin32) {

    private import minwin.mswindows;

    alias HWND WindowPeer;

    const int MinWinWindowStyle = WS_OVERLAPPEDWINDOW;

    // Get the Window object associated with the given peer.
    // The peer is accessed from the Window using the peer property.
    AbstractWindow peerToWindow(WindowPeer peer) {
        return cast(AbstractWindow)cast(void*)GetWindowLongA(peer,GWL_USERDATA);
    }
    // Associate c with the peer. This overwrites the window UserData.
    void setWindowPeer(AbstractWindow c, WindowPeer peer, int peerState) {
        SetWindowLongA(peer,GWL_USERDATA,cast(int)cast(void*)c);
        c.hasPeer = peerState;
    }
    class AbstractWindow : Component {
        WindowPeer peer;
        MenuBar menubar;

        mixin CommonWindowImpl!();

        void title(char[] str) {
            BOOL ok;
            if (useWfuncs)
                ok = SetWindowTextW(peer,toUTF16z(str));
            else
                ok = SetWindowTextA(peer,toMBSz(str));
            sysAssert(ok != false, "Failed to set window title");
        }

        char[] title() {
            if (useWfuncs) {
                wchar[64] res;
                int len = GetWindowTextW(peer,res.ptr,res.length);
                return toUTF8(res[0..len]);
            }
            else {
                char[64] res;
                int len = GetWindowTextA(peer,res.ptr,res.length);
                return fromMBSz(res[0..len].ptr);
            }
        }

        PeerForAdd getPeerForAdd() { return peer; }

        void disposePeer() {
            if (hasPeer == OWNS_PEER) {
                BOOL ok = DestroyWindow(peer);
                sysAssert(ok != false, "Failed to destroy window");
            }
            hasPeer = NO_PEER;
            //delete WindowList[this]; // remove global reference
            WindowList.remove(this); // remove global reference
        }

        void close() {
            SendMessageA(peer,WM_CLOSE,0,0);
        }

        void visible(bool vis) {
            ShowWindow(peer,vis ? SW_SHOW : SW_HIDE); // ignore bool result
        }

        bool visible() {
            return IsWindowVisible(peer) != 0;
        }

        void enabled(bool ena) {
            EnableWindow(peer, ena);
        }
        bool enabled() {
            return IsWindowEnabled(peer) == TRUE;
        }

        void backgroundColor(Color c) {
            version(LOG) log.writefln("making background %d %d %d",
                cast(int)c.red,
                cast(int)c.green,
                cast(int)c.blue);
            if (backgroundPeer)
                DeleteObject(backgroundPeer);
            backgroundPeer = CreateSolidBrush(c.native);
            // use GetSysColorBrush?
        }

        // returns client bounds in screen coordinates
        void getBounds(inout Rect r) {
            BOOL ok = GetClientRect(peer,&r.native);
            sysAssert(ok != false, "Failed to get client rect");
            Point pt = XY(r.left,r.top);
            ClientToScreen(peer,&pt.native);
            int x,y;
            if (parent) parent.getPeerOffset(x,y);
            r.LTWH(pt.x+x,pt.y+y,r.width,r.height);
        }

        // should be the same as AdjustWindowRect but it seems like
        // that doesn't account for the title bar.
        protected final void adjustBounds(inout Rect r) {
            BOOL ok = AdjustWindowRect(&r.native,MinWinWindowStyle,menubar !is null);
            sysAssert(ok != false, "Failed to adjust window bounds");
        }

        void setBounds(inout Rect r) {
            Rect r2 = r;
            adjustBounds(r2);
            int x,y;
            if (parent) parent.getPeerOffset(x,y);
            BOOL ok = MoveWindow(peer,r2.left+x,r2.top+y,r2.width,r2.height,true);
            sysAssert(ok != false, "Failed to move window in setBounds");
            childLayoutDirty = true;
        }

        alias Component.size size;
        void size(Point s) {
            Rect r;
            getBounds(r);
            r.width = s.x;
            r.height = s.y;
            adjustBounds(r);
            BOOL ok = MoveWindow(peer,r.left,r.top,r.width,r.height,true);
            sysAssert(ok != false, "Failed to move window in size");
            childLayoutDirty = true;
        }

        void toFront() {
            BOOL ok = BringWindowToTop(peer);
            sysAssert(ok != false, "Failed to bring window to front");
        }

        // mark as needing a repaint and post event to event queue
        void repaint() {
            InvalidateRect(peer,null,clearBackgroundOnPaint);
            super.repaint();
        }

        void repaint(inout Rect r) {
            InvalidateRect(peer,&r.native,clearBackgroundOnPaint);
        }

        mixin CommonEventSourceImpl!();

        int WindowProc(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam) {
            //version (LOG) log.printf(" in windowproc msg %x LowW %x HiW %x L %x\n",
            //uMsg,cast(int)LOWORD(wParam),cast(int)HIWORD(wParam),lParam);
            bool doDefault = true;
            if (uMsg <= WM_KEYLAST && uMsg >= WM_KEYFIRST) {
                //  version(LOG) log.writefln("got key event %d %d",uMsg,wParam);
                keyDelegate(this, cast(KeyEvent*)&gApp.event);
            } else if (uMsg <= WM_MOUSELAST && uMsg >= WM_MOUSEFIRST) {
                mouseDelegate(this, cast(MouseEvent*)&gApp.event);
            } else {
                switch (uMsg) {
                case WM_COMMAND:
                    //      version (LOG) log.printf(" got command %x %x from %x\n",
                    //                   HIWORD(wParam),LOWORD(wParam),lParam);
                    Component c = peerToWindowChild(cast(HWND)lParam);
                    //      version (LOG) log.printf(" got pointer %p\n",c);
                    if (c !is null) {
                        c.doCommand(wParam);
                    } else {
                        doCommand(LOWORD(wParam));
                    }
                    break;
                case WM_PAINT:
                    //      version (LOG) log.writefln(" got paint");
                    layout(true);
                    GContext gc = newGContext();
                    gc.peer = BeginPaint(peer, &gc.paintstruct);
                    sysAssert(gc.peer !is null, "Failed to get DC in repaintNow");
                    //      version(LOG)log.writefln("Paint rect: %s",toRect(gc.paintstruct.rcPaint).toString);
                    gc.hasPeer = FOREIGN_PEER; // don't call DisposeDC
                    if (clearBackgroundOnPaint && backgroundPeer) {
                        Point s = super.size;
                        Rect r = LTWH(0,0,s.x,s.y);
                        //          version(LOG)log.writefln("painting background %d %d",width,height);
                        FillRect(gc.peer,&r.native,backgroundPeer);
                    }
                    if (!paintDelegate.isEmpty) {
                        paintDelegate(this,gc);
                    }
                    EndPaint(peer, &gc.paintstruct);
                    gc.dispose();
                    break;
                    /*
                case CBN_DROPDOWN:
                    // TODO: doesn't work!
                    Rect r;
                    HWND ctrl = cast(HWND)lParam;
                    BOOL ok = GetWindowRect(ctrl,&r.native);
                    //      sysAssert(ok != false, "Failed to get drop down bounds");

                    //      BOOL ok = SendMessageA(ctrl,CB_GETDROPPEDCONTROLRECT,0,cast(LPARAM)&r);
                    //      sysAssert(ok != false, "Failed to get drop down bounds");
                int height1 = SendMessageA(ctrl,CB_GETITEMHEIGHT,cast(WPARAM)-1,0);
                int n = SendMessageA(ctrl,CB_GETITEMHEIGHT,cast(WPARAM)0,0);
                version(LOG)log.writefln("got drop down command %d %d",height1,n);
                //  MoveWindow(peer,rectL(r),rectR(r),rectW(r),height1+n,false);
                //      MoveWindow(ctrl,rectL(r),rectR(r),rectW(r),rectH(r),false);
                    break;
                    */
                case WM_SIZE:
                case WM_SIZING:
                    //      version (LOG) log.writefln(" got size");
                    childLayoutDirty = true;
                    if (!windowDelegate.isEmpty) {
                        WindowEvent event;
                        event.native.hwnd = hWnd;
                        event.native.wParam = wParam;
                        event.native.lParam = lParam;
                        event.native.message = uMsg;
                        windowDelegate(this, &event);
                    }
                    break;
                case WM_MOVE:
                case WM_MOVING:
                    //      version (LOG) log.writefln(" got move");
                    if (!windowDelegate.isEmpty) {
                        WindowEvent event;
                        event.native.hwnd = hWnd;
                        event.native.wParam = wParam;
                        event.native.lParam = lParam;
                        event.native.message = uMsg;
                        windowDelegate(this, &event);
                    }
                    break;
                case WM_CLOSE:
                    version (LOG) log.writefln(" got close");
                    doDefault = !cancelCloseDelegate(this);
                    break;
                case WM_DESTROY:
                    version (LOG) log.writefln(" got destroy");
                    hasPeer = NO_PEER;
                    if (quitOnDestroy)
                        gApp.exitEventLoop();
                    break;
                default:
                    //      version (LOG) log.writefln(" got default");
                    break;
                }
            }
            return doDefault;
        }
    }

    class Window : AbstractWindow {

        this(char[] title = "", char[] name = "") {
            peer = CreateWindowX("MinWinWindow", title,
                 MinWinWindowStyle,
                 CW_USEDEFAULT, CW_USEDEFAULT,
                 DefaultWindowWidth, DefaultWindowHeight,
                 HWND_DESKTOP,
                 cast(HMENU) null, gApp.hInstance, null);
            sysAssert(peer !is null, "Failed to create peer Window");
            this.name = name;
            setWindowPeer(this,peer,OWNS_PEER);
            backgroundPeer = GetStockObject(WHITE_BRUSH);
            WindowList[this] = this; // prevent garbage collection
        }

        this(WindowPeer peer) {
            setWindowPeer(this,peer,FOREIGN_PEER);
            WindowList[this] = this; // prevent garbage collection
        }
    }
    extern(Windows)
    int MinWinWindowProc(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam) {
        //        version(LOG) log.printf("in minwin window proc hwnd %p\n",hWnd);
        bool doDefault = true;
        AbstractWindow win = cast(AbstractWindow)peerToWindow(hWnd);
        //        version(LOG) log.printf("in minwin window proc win %p\n",win);
        if (win !is null)
            doDefault = win.WindowProc(hWnd,uMsg,wParam,lParam) != 0;
        if (doDefault)
            return DefWindowProcA(hWnd, uMsg, wParam, lParam);
        else
            return 0;
    }
    static this() {
        if (DefaultWindowIcon is null) {
            IconPeer ip = LoadIconA(cast(HINSTANCE) null, IDI_APPLICATION);
            DefaultWindowIcon = DefaultWindowSmallIcon = new Icon(ip);
        }
        HINSTANCE hInst = GetModuleHandleA(null);
        WNDCLASSA wc;
        wc.lpszClassName = "MinWinWindow";
        wc.style = CS_OWNDC | CS_HREDRAW | CS_VREDRAW;
        wc.lpfnWndProc = &MinWinWindowProc;
        wc.hInstance = hInst;
        wc.hIcon = DefaultWindowIcon.peer;
//        wc.hIconSm = DefaultWindowSmallIcon.peer;
        wc.hCursor = LoadCursorA(cast(HINSTANCE) null, IDC_ARROW);
        wc.hbrBackground = null;
        //        wc.hbrBackground = cast(HBRUSH) (COLOR_WINDOW + 1); // not +1 for default
        wc.lpszMenuName = null;
        wc.cbClsExtra = 0;
        wc.cbWndExtra = 0;
        RegisterClassA(&wc);
    }

} else version (GTK) {

    private import minwin.gtk;
    private import minwin.gtk_peers;

    alias GtkWindow* WindowPeer;

    class AbstractWindow : Component {
        WindowPeer peer;
        MinWinGtkPeer* content;
        MenuBar menubar;

        mixin CommonWindowImpl!();

        void title(char[] str) {
            gtk_window_set_title(peer,toStringz(str));
        }

        char[] title() {
            char* cstr = gtk_window_get_title(peer);
            if (cstr is null)
                return "";
            return cstr[0..strlen(cstr)].dup;
        }

        // TODO
        void backgroundColor(Color c) {
            GtkWidget* wid = cast(GtkWidget*)peer;
            GdkColor* nc = toNativeColor(c);
            GtkStyle* style = gtk_widget_get_style(wid);
            style.bg[GtkStateType.GTK_STATE_NORMAL] = *nc;
            gtk_widget_set_style(wid,style);
        }

        // callback from the GTK peer asking for preferred size
        private void gtkRequest(GtkWidget *w, GtkRequisition* req) {
            version(LOG)log.writefln("gtkRequest for toplevel window");
            if (layoutMgr) {
                Point s = layoutMgr.preferredSize(this);
                req.width = s.x;
                req.height = s.y;
            } else {
                req.width = 0;
                req.height = 0;
            }
            version(LOG)log.writefln("done gtkRequest for toplevel window");
        }

        // callback from GTK peer telling us our position
        private void gtkAllocate(GtkWidget *w, GtkAllocation* req) {
            version(LOG)log.writefln("gtkAllocate for toplevel window");
            Rect r = toRect(*req);
            this.size = XY(r.width,r.height);
            if (layoutMgr) {
                layoutMgr.layout(this);
            }
            childLayoutDirty = false;
            version(LOG)log.writefln("done gtkAllocate for toplevel window");
        }

        PeerForAdd getPeerForAdd() { return cast(GtkWidget*)content; }

        void disposePeer() {
            if (hasPeer == OWNS_PEER) {
                gtk_widget_destroy(cast(GtkWidget*)peer);
            }
            hasPeer = NO_PEER;
            //delete WindowList[this]; // remove global reference
            WindowList.remove(this); // remove global reference
        }

        void close() {
            if (!cancelCloseDelegate(this)) {
                gtk_widget_destroy(cast(GtkWidget*)peer);
            }
        }

        void resizable(bool vis) {
            gtk_window_set_resizable(peer,vis);
        }

        bool resizable() {
            return gtk_window_get_resizable(peer) != 0;
        }

        void visible(bool vis) {
            if (vis) {
                gtk_widget_show(cast(GtkWidget*)peer);
            } else {
                gtk_widget_hide(cast(GtkWidget*)peer);
            }
        }

        bool visible() {
            GtkObject* obj = cast(GtkObject*)peer;
            return ((obj.flags & GtkWidgetFlags.GTK_VISIBLE) != 0);
        }

        void enabled(bool b) {
            gtk_widget_set_sensitive(cast(GtkWidget*)peer,cast(int)b);
        }
        bool enabled() {
            GtkObject* obj = cast(GtkObject*)peer;
            return ((obj.flags & GtkWidgetFlags.GTK_SENSITIVE) != 0);
        }

        void getPeerOffset(inout int x, inout int y) {
            x = 0;
            y = 0;
            if (menubar !is null) {
                GtkRequisition req;
                gtk_widget_size_request(menubar.peer,&req);
                y = req.height;
            }
        }

        override void layout(bool validateParent) {
            if (parent && validateParent)
                parent.layout(true);
            if (menubar !is null) {
                positionMenuBar();
            }
            if (childLayoutDirty) {
                if (layoutMgr)
                    layoutMgr.layout(this);
                childLayoutDirty = false;
            }
            foreach( Component ch; this) {
                ch.layout(false);
            }
        }

        void positionMenuBar() {
            Rect r;
            getBounds(r);
            MenuBarPeer w = menubar.peer;
            GtkRequisition req;
            gtk_widget_size_request(menubar.peer,&req);
            r.height = req.height;
            gtk_widget_size_allocate(w,&r.native);
        }

        void getBounds(inout Rect r) {
            int x,y;
            r = toRect((cast(GtkWidget*)peer).allocation);
            if (parent) parent.getPeerOffset(x,y);
            r.left = r.left+x;
            r.top = r.top+y;
        }

        void setBounds(inout Rect r) {
            int x,y;
            if (parent) parent.getPeerOffset(x,y);
            gtk_window_move(peer,r.left+x,r.top+y);
            childLayoutDirty = true;
            gtk_window_resize(peer,r.width,r.height);
        }

        alias Component.size size;
        void size(Point s) {
            gtk_window_resize(peer,s.x,s.y);
        }

        void toFront() {
            gdk_window_raise((cast(GtkWidget*)peer).window);
        }

        // mark as needing a repaint and post event to event queue
        void repaint() {
            Rect r;
            GdkWindow* win = (cast(GtkWidget*)peer).window;
            getBounds(r);
            gdk_window_invalidate_rect(win,&r.native,1);
        }

        void repaint(inout Rect r) {
            GdkWindow* win = (cast(GtkWidget*)peer).window;
            gdk_window_invalidate_rect(win,&r.native,1);
        }

        mixin CommonEventSourceImpl!();

        GContext getGContext(Event* paintEvent = null) {
            GContext gc = newGContext();
            GtkWidget* widget = cast(GtkWidget*)content;
            GdkWindow* gwin = widget.window;
            gc.drawable = cast(GdkDrawable*)gwin;
            gc.layout = gtk_widget_create_pango_layout(widget,"");
            gc.peer = gdk_gc_new(gc.drawable);
            gc.hasPeer = OWNS_PEER;
            gc.paintEvent = cast(GdkEventExpose*)paintEvent;
            return gc;
        }

        Image getCompatibleImage(int width, int height) {
            GtkWidget* widget = cast(GtkWidget*)content;
            GdkDrawable* gwin = cast(GdkDrawable*)widget.window;
            int depth = gdk_drawable_get_depth(gwin);
            ImagePeer bm = gdk_pixmap_new(gwin,width,height,depth);
            version(LOG) log.writefln("create bitmap %x",cast(int)bm);
            Image res = new Image(bm);
            res.width = width;
            res.height = height;
            res.hasPeer = OWNS_PEER;
            return res;
        }

        Image loadCompatibleImage(char[] imageKey, char[] fmt = "bmp") {
            GtkWidget* widget = cast(GtkWidget*)content;
            GdkDrawable* gwin = cast(GdkDrawable*)widget.window;
            GError* err;
            char[] fname = imageKey;
            if (gApp.resourcePath.length > 0) {
                fname = gApp.resourcePath ~ "/" ~ fname;
            }
            fname = fname ~ "." ~ fmt;
            GdkPixbuf* pbuf = gdk_pixbuf_new_from_file(toStringz(fname),&err);
            int width = gdk_pixbuf_get_width(pbuf);
            int height = gdk_pixbuf_get_height(pbuf);
            int depth = gdk_drawable_get_depth(gwin);
            GdkColormap* cmap = gdk_drawable_get_colormap(gwin);
            ImagePeer bm = gdk_pixmap_new(gwin,width,height,depth);
            gdk_pixbuf_render_pixmap_and_mask_for_colormap(pbuf,cmap,&bm,null,0);
            Image res = new Image(bm);
            res.width = width;
            res.height = height;
            res.hasPeer = OWNS_PEER;
            return res;
        }
    }

    class Window : AbstractWindow {
        this(char[] title = "", char[] name = "") {
            char* str = toStringz(title);
            // TODO: application name vs window name??
            peer = cast(GtkWindow*)gtk_window_new(GtkWindowType.GTK_WINDOW_TOPLEVEL);
            gtk_window_set_title(peer,str);
            gtk_window_set_default_size(peer,DefaultWindowWidth,DefaultWindowHeight);
            backgroundColor = RGB(255,255,255);
            this.name = name;
            gtk_widget_add_events(cast(GtkWidget*)peer,GdkEventMask.GDK_KEY_PRESS_MASK |
                    GdkEventMask.GDK_KEY_RELEASE_MASK |
                    GdkEventMask.GDK_EXPOSURE_MASK |
                    GdkEventMask.GDK_STRUCTURE_MASK |
                    GdkEventMask.GDK_POINTER_MOTION_MASK |
                    GdkEventMask.GDK_BUTTON_PRESS_MASK |
                    GdkEventMask.GDK_BUTTON_RELEASE_MASK);
            g_signal_connect_data(peer,"destroy",
                    cast(GCallback)&mw_destroy_callback,
                    cast(gpointer)this,
                    null,cast(GConnectFlags)0);
            g_signal_connect_data(peer,"delete-event",
                    cast(GCallback)&mw_close_callback,
                    cast(gpointer)this,
                    null,cast(GConnectFlags)0);
            g_signal_connect_data(peer,"configure-event",
                    cast(GCallback)&mw_notify_callback,
                    cast(gpointer)this,
                    null,cast(GConnectFlags)0);
            setWindowPeer(this,peer,OWNS_PEER);
            WindowList[this] = this; // prevent garbage collection

            GtkWidget* wcontent = MinWinGtkPeer_new();
            content = cast(MinWinGtkPeer*)wcontent;
            gtk_widget_set_sensitive(wcontent,true);
            content.sizeRequest = &gtkRequest;
            content.sizeAllocate = &gtkAllocate;
            gtk_container_add(cast(GtkContainer*)peer,wcontent);
            g_signal_connect_data(peer,"expose-event",
                    cast(GCallback)&mw_expose_callback,
                    cast(gpointer)this,
                    null,GConnectFlags.G_CONNECT_AFTER);
            g_signal_connect_data(peer,"key-press-event",
                    cast(GCallback)&mw_key_callback,
                    cast(gpointer)this,
                    null,GConnectFlags.G_CONNECT_AFTER);
            g_signal_connect_data(peer,"key-release-event",
                    cast(GCallback)&mw_key_callback,
                    cast(gpointer)this,
                    null,GConnectFlags.G_CONNECT_AFTER);
            g_signal_connect_data(peer,"motion-notify-event",
                    cast(GCallback)&mw_win_mouse_callback,
                    cast(gpointer)this,
                    null,GConnectFlags.G_CONNECT_AFTER);
            g_signal_connect_data(peer,"button-press-event",
                    cast(GCallback)&mw_win_button_callback,
                    cast(gpointer)this,
                    null,GConnectFlags.G_CONNECT_AFTER);
            g_signal_connect_data(peer,"button-release-event",
                    cast(GCallback)&mw_win_button_callback,
                    cast(gpointer)this,
                    null,GConnectFlags.G_CONNECT_AFTER);
            gtk_widget_realize(wcontent);
            gtk_widget_show(wcontent);
        }

        this(WindowPeer peer) {
            setWindowPeer(this,peer,FOREIGN_PEER);
            WindowList[this] = this; // prevent garbage collection
        }

    }


    // Get the Window object associated with the given peer.
    // The peer is accessed from the Window using the peer property.
    AbstractWindow peerToWindow(WindowPeer peer) {
        gpointer ptr = g_object_get_data(cast(GObject*)peer,"MinWinUserData");
        return cast(AbstractWindow)ptr;
    }

    // Associate c with the peer. This overwrites the window UserData.
    void setWindowPeer(AbstractWindow c, WindowPeer peer, int peerState) {
        g_object_set_data(cast(GObject*)peer,"MinWinUserData",cast(gpointer)peer);
        c.hasPeer = peerState;
    }

    extern (C) gboolean mw_expose_callback(GtkWidget* w,
                     GdkEventExpose* event,
                     gpointer ud) {
        Window win = cast(Window) ud;
        if (win) {
            win.repaintNow(cast(Event*)event);
        }
        return false;
    }

    extern (C) gboolean mw_key_callback(GtkWidget* w,
                     GdkEventKey* event,
                     gpointer ud) {
        Window win = cast(Window) ud;
        if (win && !win.keyDelegate.isEmpty) {
            win.keyDelegate(win,cast(KeyEvent*)event);
        }
        return false;
    }

    extern (C) gboolean mw_win_mouse_callback(GtkWidget* w,
                     GdkEventMotion* event,
                     gpointer ud) {
        version(LOG)log.writefln("got mouse motion event");
        Window win = cast(Window) ud;
        if (win && !win.mouseDelegate.isEmpty) {
            // TODO this should be made into a GdkEventButton
            win.mouseDelegate(win,cast(MouseEvent*)event);
        }
        return false;
    }

    extern (C) gboolean mw_win_button_callback(GtkWidget* w,
                     GdkEventButton* event,
                     gpointer ud) {
        Window win = cast(Window) ud;
        if (win && !win.mouseDelegate.isEmpty) {
            win.mouseDelegate(win,cast(MouseEvent*)event);
        }
        return false;
    }

    extern (C) void mw_destroy_callback(GtkObject* w, gpointer ud) {
        Window win = cast(Window) ud;
        if (win) {
        version(LOG)log.printf("mw_destroy_callback\n");
            win.hasPeer = NO_PEER;
            if (win.quitOnDestroy)
                gApp.exitEventLoop();
            if (win in Window.WindowList) {
                //delete Window.WindowList[win];
                Window.WindowList.remove(win);
            }
        }
    }
    extern (C) void mw_close_callback(GtkWidget* w, GdkEvent* ev, gpointer ud) {
        Window win = cast(Window) ud;
        version(LOG)log.printf("mw_close_callback\n");
        if (win)
            win.close();
    }

    extern (C) void mw_notify_callback(GtkWidget* w, GdkEvent* ev, gpointer ud) {
        Window win = cast(Window) ud;
        if (win && ev.type == GdkEventType.GDK_CONFIGURE) {
            if (!win.windowDelegate.isEmpty) {
                win.windowDelegate(win, cast(WindowEvent*)ev);
            }
        }
    }

}

