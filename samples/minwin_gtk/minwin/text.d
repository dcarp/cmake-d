/* MinWin Text class
 *
 * A single or multi-line editable text area
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.text;

public import minwin.component;

private {
    import minwin.app;
    import minwin.window;
    import minwin.peerimpl;
    import std.string;
    import std.c.string;
    import minwin.logging;
}

version (MinWin32) {

    private import minwin.mswindows;

    template TextPrefSizeImpl() {
        Point preferredSize() {
            HDC dc = GetDC(peer);
            sysAssert(dc !is null, "Failed to get label DC in preferredSize");
            SIZE s;
            try {
                Font f = standardFont(StandardFont.Gui);
                HFONT oldfont = SelectObject(dc,f.peer);
                sysAssert(oldfont !is null, "Failed to get Text font in preferredSize");
                BOOL ok;
                int len;
                if (useWfuncs) {
                    wchar[128] buf;
                    len = SendMessageW(peer,WM_GETTEXT,cast(WPARAM)128,cast(LPARAM)buf.ptr);
                    ok = GetTextExtentPoint32W(dc,buf.ptr,len,&s);
                }
                else {
                    char[128] buf;
                    len = SendMessageA(peer,WM_GETTEXT,cast(WPARAM)128,cast(LPARAM)buf.ptr);
                    ok = GetTextExtentPoint32A(dc,buf.ptr,len,&s);
                }
                SelectObject(dc,oldfont);
                sysAssert(ok != false, "Failed to get text extents in preferredSize");
            } finally {
                ReleaseDC(peer,dc);
            }
            int width = s.cx;
            int height = s.cy;
            if (userPreferredWidth() > 0)
                width = userPreferredWidth();
            if (userPreferredHeight() > 0)
                height = userPreferredHeight();
            return XY(width,height);
        }
    }

    class Text : WindowChild {
        this(Component parent, char[] text = "", char[] name = "") {
            HINSTANCE hInst = GetModuleHandleA(null);
            PeerForAdd parentp = parent.getPeerForAdd();
            peer = CreateWindowX("EDIT",text,
                 ES_AUTOHSCROLL | WS_CHILD | WS_VISIBLE,
                 0,0,20,20,parentp,
                 cast(HMENU)0,hInst,null);
            sysAssert(peer !is null, "Failed to create peer Text");
            this.name = name;
            Font f = standardFont(StandardFont.Gui);
            SendMessageA(peer,WM_SETFONT,cast(WPARAM)f.peer,0);
            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);
            version(LOG) log.writefln("done making text edit");
        }
        mixin TextPrefSizeImpl!();
        mixin WindowChildImpl!();
    }
    class MultiLineText : WindowChild {
        this(Component parent, char[] text = "", char[] name = "") {
            HINSTANCE hInst = GetModuleHandleA(null);
            PeerForAdd parentp = parent.getPeerForAdd();
            peer = CreateWindowX("EDIT",text,
                 ES_MULTILINE | WS_CHILD | WS_VISIBLE,
                 0,0,10,10,parentp,
                 cast(HMENU)0,hInst,null);
            sysAssert(peer !is null, "Failed to create peer MultiLineText");
            this.name = name;
            Font f = standardFont(StandardFont.Gui);
            SendMessageA(peer,WM_SETFONT,cast(WPARAM)f.peer,0);
            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);
        }
        mixin TextPrefSizeImpl!();
        mixin WindowChildImpl!();
    }

} else version (GTK) {

    private import minwin.gtk;

    class Text : WindowChild {
        this(Component parent, char[] text, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            char* str = toStringz(text);
            peer = gtk_entry_new();
            gtk_entry_set_text(cast(GtkEntry*)peer,str);
            gtk_container_add(cast(GtkContainer*)parentp,peer);
            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);
            gtk_widget_realize(peer);
            visible = true;
        }

        mixin WindowChildImpl!();

        char[] text() {
            char* str;
            str = gtk_entry_get_text(cast(GtkEntry*)peer);
            if (str is null)
                return "";
            else
                return str[0..strlen(str)].dup;
        }

        void text(char[] c) {
            char* str = toStringz(c);
            gtk_entry_set_text(cast(GtkEntry*)peer,str);
        }
    }

    class MultiLineText : WindowChild {
        this(Component parent, char[] text, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            char* str = toStringz(text);
            peer = gtk_text_view_new();
            GtkTextView* view = cast(GtkTextView*)peer;
            GtkTextBuffer* buf = gtk_text_view_get_buffer(view);
            gtk_text_buffer_set_text(buf,text.ptr,text.length);
            gtk_text_view_set_wrap_mode(view,GtkWrapMode.GTK_WRAP_WORD);
            gtk_container_add(cast(GtkContainer*)parentp,peer);
            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);
            gtk_widget_realize(peer);
            visible = true;
        }

        mixin WindowChildImpl!();

        char[] text() {
            char* str;
            GtkTextBuffer* buffer =gtk_text_view_get_buffer(cast(GtkTextView*)peer);
            //  str = gtk_text_buffer_get_text(buffer,0);
            assert(false); // TODO
            if (str is null)
                return "";
            else
                return str[0..strlen(str)].dup;
        }

        void text(char[] c) {
            GtkTextView* view = cast(GtkTextView*)peer;
            GtkTextBuffer* buf = gtk_text_view_get_buffer(view);
            gtk_text_buffer_set_text(buf,c.ptr,c.length);
        }
    }
}
