/* MinWin Canvas class
 *
 * A Canvas is a component that fires key and mouse events and has no
 * other builtin capabilities
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.canvas;

private {
    import minwin.component;
    import minwin.event;
    import minwin.app;
    import minwin.paint;
    import minwin.logging;
    import minwin.window;
    import minwin.peerimpl;
    import minwin.image;
    import std.string;
}

template SharedCanvasImpl() {
    // events
    MultiDelegate!(Component,KeyEvent*) keyDelegate;
    MultiDelegate!(Component,MouseEvent*) mouseDelegate;
    MultiDelegate!(Component,GContext) paintDelegate;
}

version (MinWin32) {

    private import minwin.mswindows;

    // generic heavyweight window child
    class Canvas : WindowChild {
        this(Component parent, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            peer = CreateWindowA("MinWinCanvas","",
                 WS_CHILD | WS_VISIBLE,
                 0,0,10,10,parentp,
                 cast(HMENU)0,gApp.hInstance,null);
            sysAssert(peer !is null, "Failed to create peer Canvas");
            this.name = name;
            version(LOG)log.printf("canvas ctor %x peer %x\n",this,peer);
            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);
        }

        mixin SharedCanvasImpl!();
        mixin WindowChildImpl!();
        Point preferredSize(){
            int width = 60;
            int height = 60;
            if (userPreferredWidth > 0)
                width = userPreferredWidth;
            if (userPreferredHeight > 0)
                height = userPreferredHeight;
            return XY(width,height);
        }
        void backgroundColor(Color c) {
            // TODO
        }

        mixin CommonEventSourceImpl!();

        int WindowProc(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam) {
            version (LOG) log.printf(" in canvas windowproc msg %d\n",uMsg);
            bool doDefault = true;
            if (uMsg <= WM_KEYLAST && uMsg >= WM_KEYFIRST) {
                version(LOG) log.writefln("got canvas key event %d %d",uMsg,wParam);
                keyDelegate(this, cast(KeyEvent*)&gApp.event);
            } else if (uMsg <= WM_MOUSELAST && uMsg >= WM_MOUSEFIRST) {
                MouseEvent ev;
                mouseDelegate(this, cast(MouseEvent*)&gApp.event);
            } else {
                switch (uMsg) {
                case WM_PAINT:
                    version (LOG) log.writefln(" got canvas paint");
                    repaintNow();
                    break;
                case WM_DESTROY:
                    version (LOG) log.writefln(" got canvas destroy");
                    hasPeer = NO_PEER;
                default:
                    version (LOG) log.writefln(" got canvas default");
                    break;
                }
            }
            return doDefault;
        }
    }
    extern(Windows) int MinWinCanvasProc(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam) {
        version(LOG) log.printf("in minwin canvas proc hwnd %p\n",hWnd);
        bool doDefault = true;
        Canvas canvas = cast(Canvas)peerToWindowChild(hWnd);
        version(LOG) log.printf("in minwin canvas proc canvas %p\n",canvas);
        if (canvas !is null)
            doDefault = canvas.WindowProc(hWnd,uMsg,wParam,lParam) != 0;
        if (doDefault)
            return DefWindowProcA(hWnd, uMsg, wParam, lParam);
        else
            return 0;
    }
    static this() {
        HINSTANCE hInst = GetModuleHandleA(null);
        WNDCLASSA wc;
        wc.lpszClassName = "MinWinCanvas";
        wc.style = CS_OWNDC | CS_HREDRAW | CS_VREDRAW;
        wc.lpfnWndProc = &MinWinCanvasProc;
        wc.hInstance = hInst;
        wc.hCursor = LoadCursorA(cast(HINSTANCE) null, IDC_ARROW);
        wc.hbrBackground = null;
        //                wc.hbrBackground = cast(HBRUSH) (COLOR_WINDOW + 1); // not +1 for default
        wc.lpszMenuName = null;
        wc.cbClsExtra = 0;
        wc.cbWndExtra = 0;
        RegisterClassA(&wc);
    }

} else version (GTK) {

    private import minwin.gtk;

    class Canvas : WindowChild {
        this(Component parent, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            peer = gtk_drawing_area_new();
            gtk_widget_add_events(peer,GdkEventMask.GDK_KEY_PRESS_MASK |
                                                    GdkEventMask.GDK_KEY_RELEASE_MASK |
                                                    GdkEventMask.GDK_EXPOSURE_MASK |
                                                    GdkEventMask.GDK_POINTER_MOTION_MASK |
                                                    GdkEventMask.GDK_BUTTON_PRESS_MASK |
                                                    GdkEventMask.GDK_BUTTON_RELEASE_MASK);
            g_signal_connect_data(peer,"expose-event",
                                                    cast(GCallback)&mw_canvas_expose_callback,
                                                    cast(gpointer)this,
                                                    null,GConnectFlags.G_CONNECT_AFTER);
            g_signal_connect_data(peer,"key-press-event",
                                                    cast(GCallback)&mw_canvas_key_callback,
                                                    cast(gpointer)this,
                                                    null,GConnectFlags.G_CONNECT_AFTER);
            g_signal_connect_data(peer,"key-release-event",
                                                    cast(GCallback)&mw_canvas_key_callback,
                                                    cast(gpointer)this,
                                                    null,GConnectFlags.G_CONNECT_AFTER);
            g_signal_connect_data(peer,"motion-notify-event",
                                                    cast(GCallback)&mw_can_mouse_callback,
                                                    cast(gpointer)this,
                                                    null,GConnectFlags.G_CONNECT_AFTER);
            g_signal_connect_data(peer,"button-press-event",
                                                    cast(GCallback)&mw_can_button_callback,
                                                    cast(gpointer)this,
                                                    null,GConnectFlags.G_CONNECT_AFTER);
            g_signal_connect_data(peer,"button-release-event",
                                                    cast(GCallback)&mw_can_button_callback,
                                                    cast(gpointer)this,
                                                    null,GConnectFlags.G_CONNECT_AFTER);
            GtkObject* obj = cast(GtkObject*)peer;
            obj.flags |= GtkWidgetFlags.GTK_CAN_FOCUS;
            gtk_container_add(cast(GtkContainer*)parentp,peer);
            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);
            gtk_widget_realize(peer);
            visible = true;
        }

        mixin CommonEventSourceImpl!();

        void backgroundColor(Color c) {
            GdkWindow* win = (cast(GtkWidget*)peer).window;
            GdkColor nc;
            // look up GdkColor for rgb values in c using rgb colormap
            gdk_window_set_background(win,&nc);
        }

        GContext getGContext(Event* paintEvent) {
            GContext gc = newGContext();
            //                        GtkWidget* widget = cast(GtkWidget*)peer;
            GdkWindow* gwin = peer.window;
            sysAssert(gwin !is null,"Canvas peer has no window",0);
            //                        version(LOG) log.printf(" CANVAS DRAWABLE is %x\n",gwin);
            gc.drawable = cast(GdkDrawable*)gwin;
            gc.layout = gtk_widget_create_pango_layout(peer,"");
            gc.peer = gdk_gc_new(gc.drawable);
            gc.hasPeer = OWNS_PEER;
            gc.paintEvent = cast(GdkEventExpose*)paintEvent;
            return gc;
        }

        // share with Window modulo peer vs content
        Image getCompatibleImage(int width, int height) {
            GtkWidget* widget = peer;
            GdkDrawable* gwin = cast(GdkDrawable*)widget.window;
            //                        ImagePeer bm = gdk_pixbuf_new(GdkColorspace.GDK_COLORSPACE_RGB,
            //                                                                                false,8,width,height);
            int depth = gdk_drawable_get_depth(gwin);
            ImagePeer bm = gdk_pixmap_new(gwin,width,height,depth);
            version(LOG) log.writefln("create bitmap %x",cast(int)bm);
            Image res = new Image(bm);
            res.width = width;
            res.height = height;
            res.hasPeer = OWNS_PEER;
            return res;
        }
        // share with Window modulo peer vs content
        Image loadCompatibleImage(char[] imageKey, char[] fmt = "bmp") {
            GtkWidget* widget = peer;
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
        mixin SharedCanvasImpl!();
        mixin WindowChildImpl!();
    }
    extern (C) gboolean mw_canvas_expose_callback(GtkWidget* w,
                                                 GdkEventExpose* event,
                                                 gpointer ud) {
        Canvas c = cast(Canvas) ud;
        if (c) {
            c.repaintNow(cast(Event*)event);
        }
        return false;
    }
    extern (C) gboolean mw_canvas_key_callback(GtkWidget* w,
                                                 GdkEventKey* event,
                                                 gpointer ud) {
        Canvas c = cast(Canvas) ud;
        if (c && !c.keyDelegate.isEmpty) {
            c.keyDelegate(c,cast(KeyEvent*)event);
        }
        return false;
    }

    extern (C) gboolean mw_can_mouse_callback(GtkWidget* w,
                                                 GdkEventMotion* event,
                                                 gpointer ud) {
        Canvas c = cast(Canvas) ud;
        if (c && !c.mouseDelegate.isEmpty) {
            // TODO this should be made into a GdkEventButton
            c.mouseDelegate(c,cast(MouseEvent*)event);
        }
        return false;
    }
    extern (C) gboolean mw_can_button_callback(GtkWidget* w,
                                                 GdkEventButton* event,
                                                 gpointer ud) {
        Canvas c = cast(Canvas) ud;
        if (c && !c.mouseDelegate.isEmpty) {
            // TODO this should be made into a GdkEventButton
            c.mouseDelegate(c,cast(MouseEvent*)event);
        }
        return false;
    }
}
