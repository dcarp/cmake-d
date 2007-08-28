/* MinWin Group class
 *
 * A Group is a lightweight component (meaning it has
 * no peer) that contains and lays out other components.
 *
 * A GroupBox is a potentially heavyweight component that
 * puts a box and label around other components.
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.group;

private {
    import minwin.component;
    import minwin.window;
    import minwin.peerimpl;
    import minwin.logging;
    import std.string;
}

// lightweight group of other children - no peer
class Group : Component {
    Rect bounds;
    this(Component parent, char[] name = "") {
         hasPeer = NO_PEER;
         this.name = name;
         if (parent)
             parent.addChild(this);
     }
    void disposePeer(){}
    PeerForAdd getPeerForAdd() {
         return parent.getPeerForAdd();
     }
    void getPeerOffset(inout int x, inout int y) {
        int px, py;
        if (parent)
            parent.getPeerOffset(px,py);
        x = bounds.left+px;
        y = bounds.top+py;
    }
    void getBounds(inout Rect r) {
        r = bounds;
    }
    void setBounds(inout Rect r) {
        bounds = r;
        version(LOG) log.writefln("setting group bounds to %d %d %d %d",
                                r.left,r.top,r.width,r.height);
        childLayoutDirty = true;
        repaint();
    }
    void size(Point s) {
        bounds.LTWH(bounds.left,bounds.top,s.x,s.y);
        childLayoutDirty = true;
        repaint();
    }
    void visible(bool vis) {
        foreach(Component ch; this) {
            ch.visible = vis;
        }
        childLayoutDirty = true;
        layout(false);
    }
    bool visible() {
        bool vis = false;
        foreach(Component ch; this) {
            vis = vis || ch.visible();
        }
        return vis;
    }
    void enabled(bool b) {
        foreach(Component ch; this) {
            ch.enabled = b;
        }
    }
    bool enabled() {
        bool b = false;
        foreach(Component ch; this) {
            b = b || ch.enabled;
        }
        return b;
    }
}
private import minwin.layout;
unittest {
    Group g = new Group(null);
    g.layoutMgr = new FlowLayout;
    Group g2 = new Group(g);
    g2.layoutMgr = new FlowLayout;
    g2.userPreferredSize(40,50);
    Group g3 = new Group(g);
    g3.layoutMgr = new FlowLayout;
    Group g4 = new Group(g3);
    g4.userPreferredSize(50,10);
    Group g5 = new Group(g3);
    g5.userPreferredSize(60,20);
    Group g6 = new Group(g3);
    g6.userPreferredSize(70,30);
    g.pack();
    Rect r2;
    g.getBounds(r2);
    assert( r2 == LTWH(0,0,70,110) );

    g6.getBounds(r2);
    assert( r2 == LTWH(0,30,70,30) );
    g5.getBounds(r2);
    assert( r2 == LTWH(5,10,60,20) );
    g4.getBounds(r2);
    assert( r2 == LTWH(10,0,50,10) );

    int x,y;
    g6.getPeerOffset(x,y);
    assert( x == 0 );
    assert( y == 80 );
}

version (MinWin32) {

    private {
        import minwin.app;
        import minwin.mswindows;
        import std.utf;
    }

    class GroupBox : WindowChild {
        int labelHeight;

        char[] text_data;
        char[] text() { return text_data; }
        void text(char[] c) {
            text_data = c;
            SendMessageX(peer,WM_SETTEXT,0,c);
        }

        this(Component parent, char[] text, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            text_data = text;
            peer = CreateWindowX("BUTTON",text,
                 BS_GROUPBOX | WS_CHILD | WS_VISIBLE,
                 0,0,10,10,parentp,
                 cast(HMENU)0,gApp.hInstance,null);
            sysAssert(peer !is null, "Failed to create peer Button");
            setWindowChildPeer(this,peer,OWNS_PEER);
            this.name = name;
            Font f = standardFont(StandardFont.Gui);
            SendMessageA(peer,WM_SETFONT,cast(WPARAM)f.peer,0);
            HDC dc = GetDC(peer);
            HFONT oldFont = SelectObject(dc,f.peer);
            TEXTMETRICA metrics;
            GetTextMetricsA(dc,&metrics);
            labelHeight = metrics.tmHeight;
            SelectObject(dc,oldFont);
            ReleaseDC(peer,dc);
            parent.addChild(this);
        }


        void getLayoutBounds(inout Rect r) {
            super.getLayoutBounds(r);
            r.LTWH(r.left+2, r.top+labelHeight+2, r.width-4, r.height-labelHeight-4);
        }

        Point preferredSize() {
            Point s;
            if (layoutMgr) {
                s = layoutMgr.preferredSize(this);
            }
            s.y = s.y + labelHeight+4;
            s.x = s.x + 4;
            if (userPreferredWidth() > 0)
                s.x = userPreferredWidth();
            if (userPreferredHeight() > 0)
                s.y = userPreferredHeight();
            return s;
        }
        mixin WindowChildImpl!();
    }

} else version (GTK) {

    private import minwin.gtk;
    private import minwin.gtk_peers;
    private import std.c.string;

    class GroupBox : WindowChild {

        MinWinGtkPeer* content;

        char[] text() {
            char* str = gtk_frame_get_label(cast(GtkFrame*)peer);
            if (str is null)
                return "";
            else
                return str[0..strlen(str)].dup;
        }
        void text(char[] c) {
            gtk_frame_set_label(cast(GtkFrame*)peer,g_strdup(c.ptr));
        }

        this(Component parent, char[] text, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            char* str = toStringz(text);
            peer = gtk_frame_new(str);
            gtk_container_add(cast(GtkContainer*)parentp,peer);

            // add our peer to hook into GTK size allocation algorithm
            GtkWidget* wcontent = MinWinGtkPeer_new();
            content = cast(MinWinGtkPeer*)wcontent;
            gtk_widget_set_sensitive(wcontent,true);
            content.sizeRequest = &gtkRequest;
            content.sizeAllocate = &gtkAllocate;
            gtk_container_add(cast(GtkContainer*)peer,wcontent);

            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);

            gtk_widget_realize(wcontent);
            gtk_widget_show(wcontent);
            gtk_widget_realize(peer);
            visible = true;
        }

        mixin WindowChildImpl!();

        PeerForAdd getPeerForAdd() {
            return cast(GtkWidget*)content;
        }

        // callback from the GTK peer asking for preferred size
        private void gtkRequest(GtkWidget *w, GtkRequisition* req) {
            version(LOG)log.writefln("gtkRequest for groupbox");
            Point s;
            if (layoutMgr) {
                s = layoutMgr.preferredSize(this);
                req.width = s.x;
                req.height = s.y;
            } else {
                req.width = 0;
                req.height = 0;
            }
            version(LOG)log.writefln("done gtkRequest for groupbox");
        }

        // callback from GTK peer telling us our position
        private void gtkAllocate(GtkWidget *w, GtkAllocation* req) {
            version(LOG)log.writefln("gtkAllocate for groupbox");
            if (layoutMgr) {
                layoutMgr.layout(this);
            }
            childLayoutDirty = false;
            version(LOG)log.writefln("done gtkAllocate for groupbox");
        }

        void getLayoutBounds(inout Rect r) {
            GtkWidget* w = cast(GtkWidget*)content;
            r = toRect(w.allocation);
        }

    }

}

