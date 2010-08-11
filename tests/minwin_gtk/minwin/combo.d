/* MinWin ComboBox class
 *
 * Drop-down list of items to choose from.
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.combo;

private {
    import minwin.component;
    import minwin.app;
    import minwin.window;
    import minwin.peerimpl;
    import std.string;
    import minwin.logging;
}

version (MinWin32) {

    // bug: clicking on the drop down button doesn't show the list

    private import minwin.mswindows;

    class ComboBox : WindowChild {

        bool editable_data;
        bool editable() { return editable_data; } // read-only

        this(Component parent, char[][] text, bool editable = true, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            editable_data = editable;
            int style = editable?(CBS_DROPDOWN|CBS_AUTOHSCROLL):CBS_DROPDOWN;
            peer = CreateWindowX("COMBOBOX","",
                 style | WS_CHILD | WS_VISIBLE,
                 0,0,10,10,parentp,
                 cast(HMENU)0,gApp.hInstance,null);
            sysAssert(peer !is null, "Failed to create peer ComboBox");
            setWindowChildPeer(this,peer,OWNS_PEER);
            foreach (char[] s; text) {
                SendMessageX(peer,CB_ADDSTRING,0,s);
            }
            this.name = name;
            Font f = standardFont(StandardFont.Gui);
            SendMessageA(peer,WM_SETFONT,cast(WPARAM)f.peer,0);
            parent.addChild(this);
        }
        mixin WindowChildImpl!();
        Point preferredSize(){
            //            width = SendMessageA(peer,CB_GETDROPPEDWIDTH,0,0);
            //            height = SendMessageA(peer,CB_GETITEMHEIGHT,cast(WPARAM)-1,0);
            int width = 75;
            int height = 63;
            return XY(width,height);
        }
        // -1 for custom text
        int selection() {
            return SendMessageA(peer,CB_GETCURSEL,0,0);
        }
        void selection(int n) {
            SendMessageA(peer,CB_SETCURSEL,n,0);
            version (LOG) log.writefln("number of item is %d",
                        SendMessageA(peer,CB_GETCOUNT,0,0));
        }
    }
    /*
    extern(Windows) int MinWinComboBoxProc(HWND hWnd, uint uMsg,
                 WPARAM wParam, LPARAM lParam) {
        if (uMsg ==
        return DefWindowProcA(hWnd, uMsg, wParam, lParam);
    }
    static this() {
        HINSTANCE hInst = GetModuleHandleA(null);
        WNDCLASSA wc;
        wc.lpszClassName = "MinWinComboBox";
        wc.style = CS_OWNDC | CS_HREDRAW | CS_VREDRAW;
        wc.lpfnWndProc = &MinWinComboBoxProc;
        wc.hInstance = hInst;
        wc.hCursor = LoadCursorA(cast(HINSTANCE) null, IDC_ARROW);
        wc.hbrBackground = cast(HBRUSH) (COLOR_WINDOW + 1); // not +1 for default
        wc.lpszMenuName = null;
        wc.cbClsExtra = 0;
        wc.cbWndExtra = 0;
        RegisterClassA(&wc);
    }
    */
} else version (GTK) {

    private import minwin.gtk;
    private import std.c.string;

    class ComboBox : WindowChild {

        bool editable_data;
        bool editable() { return editable_data; } // read-only

        this(Component parent, char[][] text, bool editable = true, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            editable_data = editable;
            if (editable_data) {
                peer = gtk_combo_box_entry_new_text();
            } else {
                peer = gtk_combo_box_new_text();
            }
            GtkComboBox* box = cast(GtkComboBox*)peer;
            foreach (char[] s; text)
                gtk_combo_box_append_text(box,toStringz(s));
            gtk_container_add(cast(GtkContainer*)parentp,peer);
            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);
            gtk_widget_realize(peer);
            visible = true;
        }

        // -1 for custom text
        int selection() {
            GtkComboBox* box = cast(GtkComboBox*)peer;
            return gtk_combo_box_get_active(box);
        }
        void selection(int n) {
            GtkComboBox* box = cast(GtkComboBox*)peer;
            gtk_combo_box_set_active(box,n);
        }

        char[] text() {
            char* str;
            if (!editable) {
                GtkComboBox* box = cast(GtkComboBox*)peer;
                GtkTreeModel* model = gtk_combo_box_get_model(box);
                GtkTreeIter iter;
                if (gtk_tree_model_get_iter_first(model,&iter)) {
                    int n = selection();
                    GValue* val;
                    while (n--) {
                        gtk_tree_model_iter_next(model,&iter);
                    }
                    gtk_tree_model_get_value(model,&iter,0,val);
                    str = *(cast(char**)val);
                    g_value_unset(val);
                }
            } else {
                GtkEntry* box = cast(GtkEntry*)((cast(GtkBin*)peer).child);
                str = gtk_entry_get_text(box);
            }
            if (str is null)
                return "";
            else
                return str[0..strlen(str)].dup;
        }

        void text(char[] s) {
            if (editable) {
                GtkEntry* box = cast(GtkEntry*)((cast(GtkBin*)peer).child);
                char* str = toStringz(s);
                gtk_entry_set_text(box,str);
            }
        }

        mixin WindowChildImpl!();
    }
}
