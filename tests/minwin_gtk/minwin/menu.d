
module minwin.menu;

public import minwin.window;

private {
    import minwin.app;
    import std.string;
}

// todo: disposePeer?

version (MinWin32) {
    private import minwin.mswindows;

    alias HMENU MenuPeer;
    alias HMENU MenuBarPeer;

    class MenuBar {
        MenuBarPeer peer;
        char[] name;
        Window owner;
        Menu[] menus;

        this(Window parent, char[] name = "") {
            peer = CreateMenu();
            BOOL ok = SetMenu(parent.peer,peer); // destroy old menu?
            sysAssert(ok != false, "Failed to set menu");
            owner = parent;
            owner.menubar = this;
            this.name = name;
        }
    }

    class Menu {
        MenuPeer peer;
        char[] name;
        MenuBar parentBar;

        this(inout MenuBar bar, char[] label, char[] name = "") {
            this.name = name;
            parentBar = bar;
            peer = CreateMenu();
            BOOL ok = AppendMenuX(bar.peer,MF_POPUP,cast(void*)peer,label);
            sysAssert(ok != false, "Failed to append to menubar");
            bar.menus ~= this;
            ok = DrawMenuBar(bar.owner.peer);
            sysAssert(ok != false, "Failed to draw menu bar");
        }
        void addSeparator() {
            BOOL ok = AppendMenuA(peer,MF_SEPARATOR,null,null);
            sysAssert(ok != false, "Failed to append separator to menu");
        }
        void add(char[] name, int cmd) {
            BOOL ok = AppendMenuX(peer,MF_STRING,cast(void*)(cmd),name);
            sysAssert(ok != false, "Failed to append to menu");
        }
    }
} else version (GTK) {

    private import minwin.gtk;

    alias GtkWidget* MenuPeer;
    alias GtkWidget* MenuBarPeer;

    class MenuBar {
        MenuBarPeer peer;
        char[] name;
        Window owner;
        Menu[] menus;

        this(Window parent, char[] name = "") {
            this.name = name;
            peer = gtk_menu_bar_new();
            GtkContainer* p = cast(GtkContainer*)parent.getPeerForAdd();
            gtk_container_add(p,peer);
            gtk_widget_show(peer);
            owner = parent;
            owner.menubar = this;
        }
    }

    class Menu {
        MenuPeer peer;
        char[] name;
        MenuBar parentBar;
        GtkWidget* trigger;

        this(inout MenuBar bar, char[] label, char[] name = "") {
            this.name = name;
            parentBar = bar;
            char* cname = toStringz(label);
            peer = gtk_menu_new();
            trigger = gtk_menu_item_new_with_label(cname);
            gtk_menu_item_set_submenu(cast(GtkMenuItem*)trigger,peer);
            gtk_menu_shell_append(cast(GtkMenuShell*)bar.peer,trigger);
            gtk_widget_show(trigger);
            bar.menus ~= this;
        }

        void addSeparator() {
            GtkWidget* item = gtk_separator_menu_item_new();
            gtk_menu_shell_append(cast(GtkMenuShell*)peer,item);
            gtk_widget_show(item);
        }

        void add(char[] name, int cmd) {
            char* cname = toStringz(name);
            GtkWidget* item = gtk_menu_item_new_with_label(cname);
            gtk_menu_shell_append(cast(GtkMenuShell*)peer,item);
            g_object_set_data(cast(GObject*)item,"MinWinItemCommand",
            cast(gpointer)cmd);
            g_signal_connect_data(item,"activate",
                    cast(GCallback)&mw_menuitem_callback,
                    cast(gpointer)parentBar.owner,
                    null,cast(GConnectFlags)0);
            gtk_widget_show(item);
        }
    }
    extern (C)
    void mw_menuitem_callback(GtkWidget* w, gpointer ud) {
        Window x = cast(Window)ud;
        if (x) {
            int cmd = cast(int)g_object_get_data(cast(GObject*)w,"MinWinItemCommand");
            x.doCommand(cmd);
        }
    }
}
