/* MinWin Button classes
 *
 * Various button classes like PushButtons
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.button;

public import minwin.component;

private {
    import minwin.icon;
    import minwin.app;
    import minwin.window;
    import minwin.peerimpl;
    import minwin.logging;
    import std.string;
    import minwin.peer;
}

abstract class AbstractButton : WindowChild {
    int cmd;
    Icon icon();
    void icon(Icon c);
    char[] text();
    void text(char[] c);

    MultiDelegate!(Component) actionDelegate;

    void doCommand(int cmd) {
        // only command is action command
        version(LOG) log.writefln("calling action delegate");
        if (cmd == ButtonClickedCommand) {
            actionDelegate(cast(Component)this);
            if (this.cmd != 0) {
                super.doCommand(this.cmd);
            }
        }
    }
}

abstract class AbstractToggleButton : AbstractButton {
    bool selected();
    void selected(bool x);
}
version (MinWin32) {
    version = SimpleToggleGroup;
}
version (SimpleToggleGroup) {
    private import minwin.dialog;
    // manages selected state between several ToggleButtons
    class ToggleGroup {
        AbstractToggleButton[] buttons;
        void addButton(AbstractToggleButton[] btns ...) {
            buttons ~= btns;
            foreach(b; btns) {
                b.actionDelegate ~= &select;
            }
        }
        void select(Component c) {
            version (LOG) log.writefln("selecting component ", c);
            foreach(AbstractToggleButton b; buttons) {
                b.selected = (b is c);
            }
        }
        void select(int index) {
            foreach(int n, AbstractToggleButton b; buttons) {
                b.selected = n == index;
            }
        }
        int selected() {
            foreach(int n, AbstractToggleButton b; buttons) {
                version(LOG)log.printf("testing button %d %x\n",n,b);
                if (b && b.selected)
                    return n;
            }
            version(LOG)log.printf(" no button selected??\n");
            return 0;
        }
    }
}

version (MinWin32) {
    private import minwin.mswindows;

    const int ButtonClickedCommand = BN_CLICKED;

    template PreferredSizeImpl() {
        const int paddingX;
        const int paddingY;
        Point preferredSize() {
            int width,height;
            HDC dc = GetDC(peer);
            sysAssert(dc !is null, "Failed to get button DC in preferredSize");
            SIZE s;
            try {
                Font f = standardFont(StandardFont.Gui);
                HFONT oldfont = SelectObject(dc,f.peer);
                sysAssert(oldfont !is null, "Failed to get Button font in preferredSize");
                BOOL status = GetTextExtentPoint32X(dc,text_data,text_data.length,&s);
                SelectObject(dc,oldfont);
                sysAssert(status != false, "Failed to get font extents in preferredSize");
            } finally {
                ReleaseDC(peer,dc);
            }
            width = s.cx > 75-paddingX ? s.cx+paddingX*2 : 75;
            height = s.cy > 23-paddingY ? s.cy+paddingY*2 : 23;
            if (userPreferredWidth_data > 0)
                width = userPreferredWidth_data;
            if (userPreferredHeight_data > 0)
                height = userPreferredHeight_data;
            return XY(width,height);
            // Requires WinXP
            //            SIZE sz;
            //            SendMessageA(peer,BCM_GETIDEALSIZE,0,cast(int)&sz);
            //            width = sz.cx;
            //            height = sz.cy;
        }
    }

    template SelectedImpl() {
        bool selected() {
            version(LOG)log.printf("sending message...");
            bool res = SendMessageA(peer,BM_GETCHECK,0,0) == BST_CHECKED;
            version(LOG)log.printf(" got %d\n",res);
            return res;
        }
        void selected(bool x) {
            SendMessageA(peer,BM_SETCHECK,x,0);
        }
    }

    template IconTextImpl() {
        Icon icon_data;
        Icon icon() { return icon_data; }
        void icon(Icon c) {
            icon_data = c;
            SendMessageA(peer,BM_SETIMAGE,cast(WPARAM)c.peer,0);
        }

        char[] text_data;
        char[] text() { return text_data; }
        void text(char[] c) {
            text_data = c;
            SendMessageX(peer,WM_SETTEXT,0,c);
        }
    }

    class Button : AbstractButton {
        this(Component parent, char[] intext, char[] name = "") {
            paddingX = GetSystemMetrics(SM_CXFIXEDFRAME)*2;
            paddingY = GetSystemMetrics(SM_CXFIXEDFRAME)*2;
            PeerForAdd parentp = parent.getPeerForAdd();
            text_data = intext;
            peer = CreateWindowX("BUTTON",intext,
                 BS_PUSHBUTTON | WS_CHILD | WS_VISIBLE,
                 0,0,10,10,parentp,
                 cast(HMENU)0,gApp.hInstance,null);
            sysAssert(peer !is null, "Failed to create peer Button");
            finish_button_setup(this,parent,name,peer);
        }
        mixin WindowChildImpl!();
        mixin IconTextImpl!();
        mixin PreferredSizeImpl!();
    }
    class CheckBox : AbstractToggleButton {
        this(Component parent, char[] intext, char[] name = "") {
            paddingX = GetSystemMetrics(SM_CXMENUCHECK);
            paddingY = GetSystemMetrics(SM_CYFIXEDFRAME)*2;
            PeerForAdd parentp = parent.getPeerForAdd();
            text_data = intext;
            peer = CreateWindowX("BUTTON",intext,
                 BS_AUTOCHECKBOX | WS_CHILD | WS_VISIBLE,
                 0,0,10,10,parentp,
                 cast(HMENU)0,gApp.hInstance,null);
            sysAssert(peer !is null, "Failed to create peer CheckBox");
            finish_button_setup(this,parent,name,peer);
        }
        mixin WindowChildImpl!();
        mixin SelectedImpl!();
        mixin IconTextImpl!();
        mixin PreferredSizeImpl!();
    }
    class RadioButton : AbstractToggleButton {
        this(Component parent, char[] intext, char[] name = "") {
            paddingX = GetSystemMetrics(SM_CXMENUCHECK);
            paddingY = GetSystemMetrics(SM_CYFIXEDFRAME)*2;
            PeerForAdd parentp = parent.getPeerForAdd();
            text_data = intext;
            peer = CreateWindowX("BUTTON",intext,
                 BS_RADIOBUTTON | WS_CHILD | WS_VISIBLE,
                 0,0,10,10,parentp,
                 cast(HMENU)0,gApp.hInstance,null);
            sysAssert(peer !is null, "Failed to create peer RadioButton");
            finish_button_setup(this,parent,name,peer);
        }
        mixin WindowChildImpl!();
        mixin SelectedImpl!();
        mixin IconTextImpl!();
        mixin PreferredSizeImpl!();
    }
    class ToggleButton : AbstractToggleButton {
        this(Component parent, char[] intext, char[] name = "") {
            paddingX = GetSystemMetrics(SM_CXFIXEDFRAME)*2;
            paddingY = GetSystemMetrics(SM_CYFIXEDFRAME)*2;
            PeerForAdd parentp = parent.getPeerForAdd();
            text_data = intext;
            peer = CreateWindowX("BUTTON",intext,
                 BS_PUSHLIKE | BS_AUTOCHECKBOX | WS_CHILD | WS_VISIBLE,
                 0,0,10,10,parentp,
                 cast(HMENU)0,gApp.hInstance,null);
            sysAssert(peer !is null, "Failed to create peer ToggleButton");
            finish_button_setup(this,parent,name,peer);
        }
        mixin WindowChildImpl!();
        mixin SelectedImpl!();
        mixin IconTextImpl!();
        mixin PreferredSizeImpl!();
    }

    private void finish_button_setup(AbstractButton b,Component parent,
                     char[] name, WindowChildPeer peer) {
        setWindowChildPeer(b,peer,OWNS_PEER);
        b.name = name;
        Font f = standardFont(StandardFont.Gui);
        SendMessageA(peer,WM_SETFONT,cast(WPARAM)f.peer,0);
        parent.addChild(b);
    }

} else version (GTK) {

    private import minwin.gtk;
    private import std.c.string;

    const int ButtonClickedCommand = 1;

    abstract class HeavyAbstractToggleButton : AbstractToggleButton {
        mixin WindowChildImpl!();
    }

    // manages selected state between several ToggleButtons
    class ToggleGroup {
        HeavyAbstractToggleButton[] buttons;
        void addButton(HeavyAbstractToggleButton[] btns ...) {
            buttons ~= btns;
            foreach(b; btns) {
                RadioButton rb = cast(RadioButton)b;
                if (rb is null) {
                    b.actionDelegate ~= &select;
                } else {
                    // set the RadioButton group to its sibling, if any
                    if (buttons.length != 0) {
                        GtkRadioButton* rbpeer1 = cast(GtkRadioButton*)buttons[0].peer;
                        GtkRadioButton* rbpeer = cast(GtkRadioButton*)rb.peer;
                        GSList* group = gtk_radio_button_get_group(rbpeer1);
                        gtk_radio_button_set_group(rbpeer,group);
                    }
                }
            }
        }
        void select(Component c) {
            version (LOG) log.writefln("selecting component ", c);
            foreach(HeavyAbstractToggleButton b; buttons) {
                b.selected = (b is c);
            }
        }
        void select(int index) {
            foreach(int n, HeavyAbstractToggleButton b; buttons) {
                b.selected = n == index;
            }
        }
        int selected() {
            foreach(int n, HeavyAbstractToggleButton b; buttons) {
                if (b.selected)
                    return n;
            }
        }
    }

    template SelectedImpl() {
        bool selected() {
            return gtk_toggle_button_get_active(cast(GtkToggleButton*)peer) != 0;
        }
        void selected(bool x) {
            gtk_toggle_button_set_active(cast(GtkToggleButton*)peer,x);
        }
    }

    template IconTextImpl() {
        Icon icon_data;
        Icon icon() { return icon_data; }
        void icon(Icon c) {
            icon_data = c;
            //            SendMessageA(peer,BM_SETIMAGE,cast(WPARAM)c.peer,0);
        }
        char[] text() {
            char* str = gtk_button_get_label(cast(GtkButton*)peer);
            if (str is null)
                return "";
            else
                return str[0..strlen(str)].dup;
        }
        void text(char[] c) {
            gtk_button_set_label(cast(GtkButton*)peer,toStringz(c));
        }
    }

    class Button : AbstractButton {
        this(Component parent, char[] text, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            char* str = toStringz(text);
            peer = gtk_button_new_with_label(str);
            finish_button_setup(this,peer,parentp,parent);
        }
        mixin WindowChildImpl!();
        mixin IconTextImpl!();
    }
    class CheckBox : HeavyAbstractToggleButton {
        this(Component parent, char[] text, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            char* str = toStringz(text);
            peer = gtk_check_button_new_with_label(str);
            finish_button_setup(this,peer,parentp,parent);
        }
        mixin SelectedImpl!();
        mixin IconTextImpl!();
    }
    class RadioButton : HeavyAbstractToggleButton {
        this(Component parent, char[] text, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            char* str = toStringz(text);
            peer = gtk_radio_button_new_with_label(null,str);
            finish_button_setup(this,peer,parentp,parent);
        }
        mixin SelectedImpl!();
        mixin IconTextImpl!();
    }
    class ToggleButton : HeavyAbstractToggleButton {
        this(Component parent, char[] text, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            char* str = toStringz(text);
            peer = gtk_toggle_button_new_with_label(str);
            finish_button_setup(this,peer,parentp,parent);
        }
        mixin SelectedImpl!();
        mixin IconTextImpl!();
    }
    private void finish_button_setup(AbstractButton b,
                     WindowChildPeer peer,
                     PeerForAdd parentp,
                     Component parent) {
        gtk_widget_set_sensitive(peer,true);
        gtk_container_add(cast(GtkContainer*)parentp,peer);
        g_signal_connect_data(peer,"clicked",
                cast(GCallback)&mw_buttonclick_callback,
                cast(gpointer)b,
                null,cast(GConnectFlags)0);
        setWindowChildPeer(b,peer,OWNS_PEER);
        parent.addChild(b);
        gtk_widget_realize(peer);
        b.visible = true;
    }
    extern (C) void mw_buttonclick_callback(GtkButton *but, gpointer ud) {
        Component c = cast(Component) ud;
        if (c) {
            c.doCommand(ButtonClickedCommand);
        }
    }
}
