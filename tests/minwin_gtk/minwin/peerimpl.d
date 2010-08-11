/* MinWin PeerImpl module
 *
 * Mixin template to implement heavyweight peer for window children.
 * Plus PeerWrapper to insert peer children into the MinWin tree.
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.peerimpl;

private {
    import minwin.app;
    import minwin.component;
    import minwin.window;
    import std.string;
    import minwin.logging;
}


version (MinWin32) {
    public import minwin.paint;
    private import minwin.mswindows;

    template WindowChildImpl() {

        WindowChildPeer peer;
        PeerForAdd getPeerForAdd() { return peer; }
        WindowChildPeer getPeer() { return peer;}

        void disposePeer(){
            if (hasPeer == OWNS_PEER && parent is null) {
                int ok = DeleteObject(peer);
                sysAssert(ok != false, "Failed to dispose peer child");
            }
            hasPeer = NO_PEER;
        }

        void visible(bool vis) {
            ShowWindow(peer,vis ? SW_SHOW : SW_HIDE); // ignore bool result
        }
        bool visible() {
            return IsWindowVisible(peer) != 0;
        }

        void enabled(bool b) {
            EnableWindow(peer, b);
        }
        bool enabled() {
            return IsWindowEnabled(peer) == TRUE;
        }

        void requestFocus() {
            HWND old = SetFocus(peer);
            sysAssert(old !is null, "Failed to requestFocus");
        }

        // gets window bounds that encose the entire widget in parent coordinates
        void getBounds(inout Rect r) {
            Rect r2;
            BOOL ok = GetWindowRect(peer,&r2.native);
            sysAssert(ok != false, "Failed to get window bounds");
            int x,y;
            parent.getPeerOffset(x,y);
            r2.LTWH(r2.left+x,r2.top+y,r2.width,r2.height);
            r = r2;
        }

        void setBounds(inout Rect r) {
            Rect r2,r3 = r;
            getBounds(r2);
            int x,y;
            parent.getPeerOffset(x,y);
            r3.LTWH(r3.left+x,r3.top+y,r3.width,r3.height);
            BOOL ok = MoveWindow(peer,r3.left,r3.top,r3.width,r3.height,true);
            sysAssert(ok != false, "Failed to move window in setBounds");
            if (r2 != r)
                childLayoutDirty = true;
        }

        alias Component.size size;
        void size(Point s) {
            Rect r2;
            BOOL ok = GetWindowRect(peer,&r2.native);
            sysAssert(ok != false, "Failed to get window rect in size");
            ok = MoveWindow(peer,r2.left,r2.top,s.x,s.y,true);
            sysAssert(ok != false, "Failed to move window in size");
            if (r2.width != s.x || r2.height != s.y)
                childLayoutDirty = true;
        }

        void repaint() {
            BOOL ok = InvalidateRect(peer,null,clearBackgroundOnPaint);
            sysAssert(ok != false, "Failed to invalidate rect in repaint");
        }

        GContext getGContext() {
            GContext gc = newGContext();
            gc.peer = GetDC(peer);
            sysAssert(gc.peer !is null, "Failed to get DC in getGContext");
            gc.hasPeer = OWNS_PEER;
            return gc;
        }
    }

    // Get the Component object associated with the given peer.
    // The peer is accessed from the Component using the peer property.
    WindowChild peerToWindowChild(WindowChildPeer peer) {
        return cast(WindowChild)cast(void*)GetWindowLongA(peer,GWL_USERDATA);
    }
    // Associate c with the peer. On Windows this overwrites the
    // window UserData.
    void setWindowChildPeer(Component c, WindowChildPeer peer,int peerState) {
        SetWindowLongA(peer,GWL_USERDATA,cast(int)cast(void*)c);
        c.hasPeer = peerState;
        // TODO investigate if we need a destroy callback to clear hasPeer
    }

} else version(GTK) {

    private import minwin.gtk;

    extern (C)
    gint mw_exposechild_callback(GtkWidget w, GdkEventExpose*ev,
                gpointer ud) {
        Component win = cast(Component) ud;
        if (win) {
            win.layout(true);
        }
        return 0;
    }

    template WindowChildImpl() {

        WindowChildPeer peer;

        PeerForAdd getPeerForAdd() { return peer; }
        WindowChildPeer getPeer() { return peer;}

        void disposePeer() {
            if (hasPeer == OWNS_PEER && parent is null)
                gtk_widget_destroy(peer);
            hasPeer = NO_PEER;
        }

        void visible(bool vis) {
            if (vis) {
                gtk_widget_show(peer);
            } else {
                gtk_widget_hide(peer);
            }
        }

        bool visible() {
            GtkObject* obj = cast(GtkObject*)peer;
            return ((obj.flags & GtkWidgetFlags.GTK_VISIBLE) != 0);
        }

        void enabled(bool b) {
            gtk_widget_set_sensitive(peer,cast(int)b);
        }
        bool enabled() {
            GtkObject* obj = cast(GtkObject*)peer;
            return ((obj.flags & GtkWidgetFlags.GTK_SENSITIVE) != 0);
        }

        override void requestFocus() {
            GtkObject* obj = cast(GtkObject*)peer;

            //            printf("%d\n",            cast(int)((obj.flags & GtkWidgetFlags.GTK_CAN_FOCUS) != 0));
            gtk_widget_grab_focus(peer);
        }

        void getBounds(inout Rect r) {
            int x,y,x2,y2,w,h,depth;
            parent.getPeerOffset(x,y);
            //            gdk_window_get_geometry(peer.window,&x2,&y2,&w,&h,&depth);
            Rect r2 = toRect(peer.allocation);
            r.LTWH(r2.left+x,r2.top+y,r2.width,r2.height);
            //            version(LOG) log.writefln("get bounds got %d %d %d %d",
            //                  x2+x,y2+y,w,h);
        }

        void setBounds(inout Rect r) {
            version(LOG) log.writefln("setBounds %d %d %d %d",
             r.left,r.top,r.width,r.height);

            int x,y;
            parent.getPeerOffset(x,y);
            Rect r2 = r;
            r2.left = r2.left+x;
            r2.top = r2.top+y;

            gtk_widget_size_allocate(peer,&r2.native);
            /*
            int x2,y2,w,h,depth;
            gdk_window_get_geometry(peer.window,&x2,&y2,&w,&h,&depth);
            r.LTWH(x2+x,y2+y,w,h);
            version(LOG) log.writefln("after set bounds got %d %d %d %d",
                     x2,y2,w,h);
            if (r2.width != r.width || r2.height != r.height)
            */
            childLayoutDirty = true;
        }

        alias Component.size size;
        void size(Point s) {
            Rect r;
            getBounds(r);
            r.LTWH(r.left,r.top,s.x,s.y);
            setBounds(r);
        }

        Point preferredSize() {
            GtkRequisition req;
            gtk_widget_size_request(peer,&req);
            int width = req.width;
            int height = req.height;
            if (userPreferredWidth > 0)
                width = userPreferredWidth;
            if (userPreferredHeight > 0)
                height = userPreferredHeight;
            return XY(width,height);
        }

        // mark as needing a repaint and post event to event queue
        void repaint() {
            Rect r;
            getBounds(r);
            gdk_window_invalidate_rect(peer.window,&r.native,true);
        }
    }

    WindowChild peerToWindowChild(WindowChildPeer peer) {
        gpointer ptr = g_object_get_data(cast(GObject*)peer,"MinWinUserData");
        return cast(WindowChild)ptr;
    }
    void setWindowChildPeer(Component c, WindowChildPeer peer,int peerState) {
        g_object_set_data(cast(GObject*)peer,"MinWinUserData",cast(gpointer)peer);
        g_signal_connect_data(peer,"destroy",
                cast(GCallback)&mw_wcdestroy_callback,
                cast(gpointer)c,
                null,GConnectFlags.G_CONNECT_AFTER);
        c.hasPeer = peerState;
    }
    extern (C)
    void mw_wcdestroy_callback(GtkObject w, gpointer ud) {
        Component wc = cast(Component) ud;
        if (wc && (wc.hasPeer == OWNS_PEER)) {
            wc.hasPeer = NO_PEER;
        }
    }
}

// assumes the peer has already been parented to the result of
// parent.getPeerForAdd
class PeerWrapper : WindowChild {
    this(Component parent, WindowChildPeer peer) {
        this.peer = peer;
        setWindowChildPeer(this,peer,FOREIGN_PEER);
        parent.addChild(this);
    }
    mixin WindowChildImpl!();
}
