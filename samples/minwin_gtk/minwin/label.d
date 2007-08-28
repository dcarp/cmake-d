/* MinWin Label class
 *
 * Static text label
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.label;

public import minwin.component;

private {
    import minwin.app;
    import minwin.window;
    import minwin.peerimpl;
    import std.string;
    import minwin.logging;
}

version (MinWin32) {

    private import minwin.mswindows;

    template LabelPrefSizeImpl() {
        Point preferredSize() {
            HDC dc = GetDC(peer);
            sysAssert(dc !is null, "Failed to get label DC in preferredSize");
            SIZE s;
            try {
                Font f = standardFont(StandardFont.Gui);
                HFONT oldfont = SelectObject(dc,f.peer);
                sysAssert(oldfont !is null, "Failed to get Label font in preferredSize");
                BOOL ok = GetTextExtentPoint32X(dc,text_data,text_data.length,&s);
                SelectObject(dc,oldfont);
                sysAssert(ok != false, "Failed to get font extents in preferredSize");
            } finally {
                ReleaseDC(peer,dc);
            }
            POINT p;
            p.x = s.cx;
            p.y = s.cy;
            if (userPreferredWidth > 0)
                p.x = userPreferredWidth;
            if (userPreferredHeight > 0)
                p.y = userPreferredHeight;
            return toPoint(p);
        }
    }

    class Label : WindowChild {
        private char[] text_data;
        this(Component parent, char[] text, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            peer = CreateWindowX("STATIC",text,
                 SS_LEFTNOWORDWRAP | WS_CHILD | WS_VISIBLE,
                 0,0,10,10,parentp,
                 cast(HMENU)0,gApp.hInstance,null);
            sysAssert(peer !is null, "Failed to create peer Label");
            this.name = name;
            text_data = text;
            Font f = standardFont(StandardFont.Gui);
            SendMessageA(peer,WM_SETFONT,cast(WPARAM)f.peer,0);
            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);
        }
        char[] text() {return text_data;}
        void text(char[] c) {
            text_data = c;
            SendMessageX(peer,WM_SETTEXT,0,c);
        }
        mixin LabelPrefSizeImpl!();
        mixin WindowChildImpl!();
    }

} else version (GTK) {

    private import minwin.gtk;
    private import std.c.string;

    class Label : WindowChild {
        this(Component parent, char[] text, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            char* str = toStringz(text);
            peer = gtk_label_new(str);
            gtk_container_add(cast(GtkContainer*)parentp,peer);
            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);
            gtk_widget_realize(peer);
            visible = true;
        }

        mixin WindowChildImpl!();

        char[] text() {
            char* str = gtk_label_get_text(cast(GtkLabel*)peer);
            if (str is null)
                return "";
            else
                return str[0..strlen(str)].dup;
        }

        void text(char[] c) {
            gtk_label_set_text(cast(GtkLabel*)peer,toStringz(c));
        }
    }
}
