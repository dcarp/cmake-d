/* MinWin ListBox class
 *
 * Display a list of items to choose from.
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.listbox;

// TODO: multi-select

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

    class ListBox : WindowChild {

        this(Component parent, char[][] text, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            HINSTANCE hInst = GetModuleHandleA(null);
            peer = CreateWindowA("LISTBOX","",
                 WS_CHILD | WS_VISIBLE,
                 0,0,10,10,parentp,
                 cast(HMENU)0,hInst,null);
            sysAssert(peer !is null, "Failed to create peer ListBox");
            foreach (char[] s; text) {
                SendMessageX(peer,LB_ADDSTRING,0,s);
            }
            Font f = standardFont(StandardFont.Gui);
            SendMessageA(peer,WM_SETFONT,cast(WPARAM)f.peer,0);
            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);
        }
        mixin WindowChildImpl!();
        Point preferredSize() {
            //            width = SendMessageA(peer,CB_GETDROPPEDWIDTH,0,0);
            int height = SendMessageA(peer,LB_GETITEMHEIGHT,cast(WPARAM)-1,0)*
                SendMessageA(peer,LB_GETCOUNT,0,0);
            int width = 75;
            return XY(width,height);
        }
        // -1 for custom text
        int selection() {
            return SendMessageA(peer,LB_GETCURSEL,0,0);
        }
        void selection(int n) {
            SendMessageA(peer,LB_SETCURSEL,n,0);
            version (LOG) log.writefln("number of item is %d",
                        SendMessageA(peer,CB_GETCOUNT,0,0));
        }
    }

} else version (GTK) {

    private import minwin.gtk;
    private import std.c.string;

    class ListBox : WindowChild {

        this(Component parent, char[][] text, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            GType the_type = g_type_fundamental(16); // means string
            GtkListStore* model = gtk_list_store_newv(1,&the_type);
            GtkTreeIter iter;
            foreach (char[] s; text) {
                gtk_list_store_append(model,&iter);
                int[3] args;
                args[0] = 0;
                args[1] = cast(int)toStringz(s);
                args[2] = -1;
                gtk_list_store_set_valist(model,&iter,&args);
            }
            peer = gtk_tree_view_new_with_model(cast(GtkTreeModel*)model);
            g_object_unref(cast(GObject*)model);
            gtk_container_add(cast(GtkContainer*)parentp,peer);
            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);
            gtk_widget_realize(peer);
            visible = true;
            gtk_tree_view_columns_autosize(cast(GtkTreeView*)peer);
            gtk_tree_view_expand_all(cast(GtkTreeView*)peer);
            GList* objs = gtk_tree_view_get_columns(cast(GtkTreeView*)peer);
            //            printf("len %d\n",g_list_length(objs));
            //            printf("cols %d\n",gtk_tree_model_get_n_columns(cast(GtkTreeModel*)model));
            g_list_free(objs);
        }

        // -1 for custom text
        int selection() {
            //            GtkComboBox* box = cast(GtkComboBox*)peer;
            //            return gtk_combo_box_get_active(box);
            return 0;
        }
        void selection(int n) {
            //            GtkComboBox* box = cast(GtkComboBox*)peer;
            //            gtk_combo_box_set_active(box,n);
        }

        char[] text() {
            char* str;
            GtkTreeView* list = cast(GtkTreeView*)peer;
            GtkTreeModel* model = gtk_tree_view_get_model(list);
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
            if (str is null)
                return "";
            else
                return str[0..strlen(str)].dup;
        }

        void text(char[] s) {
            assert(false);
        }

        mixin WindowChildImpl!();
    }
}
