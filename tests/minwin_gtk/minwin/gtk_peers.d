/* MinWin GTK Container Peer
 *
 * A MinWinGtkPeer is a GTK container that calls delegates to handle
 * size requests and allocation. These delegates are usually filled
 * by MinWin layout managers.
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.gtk_peers;

private import minwin.gtk;

private GtkContainerClass* parent_cls = null;
private GType container_type = 0;

alias void delegate(GtkWidget *widget,GtkRequisition *requisition) SizeRequestDel;
alias void delegate(GtkWidget *widget,GtkAllocation *allocation) SizeAllocateDel;
struct MinWinGtkPeer {
    GtkContainer parent;
    GList* children;
    SizeRequestDel sizeRequest;
    SizeAllocateDel sizeAllocate;
}
struct MinWinGtkPeerClass {
    GtkContainerClass parent;
}

extern (C)
GType MinWinGtkPeer_get_type() {
    if (container_type == 0) {
        static GTypeInfo info;
        info.class_size = MinWinGtkPeerClass.sizeof;
        info.class_init = cast(GClassInitFunc)&MinWinGtkPeer_class_init;
        info.instance_size = MinWinGtkPeer.sizeof;
        info.instance_init = cast(GInstanceInitFunc)&MinWinGtkPeer_init;
        container_type = g_type_register_static(gtk_container_get_type(),
                            "MinWinGtkPeer",&info, cast(GTypeFlags)0);
    }
    return container_type;
}

extern (C)
void MinWinGtkPeer_class_init(MinWinGtkPeerClass* cls,gpointer p) {
    GtkWidgetClass* wcls = cast(GtkWidgetClass*) cls;
    GtkContainerClass* ccls = cast(GtkContainerClass*) cls;

    parent_cls = cast(GtkContainerClass*)g_type_class_peek_parent (cls);
    wcls.realize = &MinWinGtkPeer_realize;
    wcls.size_request = &MinWinGtkPeer_size_request;
    wcls.size_allocate = &MinWinGtkPeer_size_allocate;
    ccls.add = &MinWinGtkPeer_add;
    ccls.remove = &MinWinGtkPeer_remove;
    ccls.forall = &MinWinGtkPeer_forall;
    ccls.child_type = &MinWinGtkPeer_child_type;
}

extern (C)
GType MinWinGtkPeer_child_type(GtkContainer* container) {
    return gtk_widget_get_type();
}

extern (C)
void MinWinGtkPeer_init(MinWinGtkPeer* c) {
    GtkObject* obj = cast(GtkObject*)c;
    obj.flags = GtkWidgetFlags.GTK_NO_WINDOW;
    c.children = null;
    c.sizeRequest = null;
    c.sizeAllocate = null;
}

extern (C)
GtkWidget* MinWinGtkPeer_new() {
    return cast(GtkWidget*)g_object_new(MinWinGtkPeer_get_type(), null);
}

extern (C)
void MinWinGtkPeer_add(GtkContainer* c,GtkWidget* widget) {
    MinWinGtkPeer* mwc = cast(MinWinGtkPeer*)c;
    GtkWidget* child = widget;
    gtk_widget_set_parent(widget,cast(GtkWidget*)(c));
    mwc.children = g_list_append(mwc.children, child);
}

extern (C)
void MinWinGtkPeer_realize(GtkWidget *widget) {
    GtkWidgetClass* wcls = cast(GtkWidgetClass*)parent_cls;
    wcls.realize(widget);
}

extern (C)
void MinWinGtkPeer_size_request(GtkWidget* w,GtkRequisition* req) {
    MinWinGtkPeer* c = cast(MinWinGtkPeer*) w;
    req.width = 0;
    req.height = 0;
    if (c.sizeRequest !is null) {
        c.sizeRequest(w,req);
    }
}

extern (C)
void MinWinGtkPeer_size_allocate(GtkWidget* w, GtkAllocation* a){
    MinWinGtkPeer* c = cast(MinWinGtkPeer*) w;
    w.allocation = *a;
    if (c.sizeAllocate !is null) {
        c.sizeAllocate(w,a);
    }
}

extern (C)
void MinWinGtkPeer_remove(GtkContainer* container,GtkWidget* widget) {
    MinWinGtkPeer *c;
    GtkWidget *child;
    GList *children;

    c = cast(MinWinGtkPeer*)(container);

    children = c.children;
    while (children) {
        child = cast(GtkWidget*)children.data;

        if (child is widget) {
            gtk_widget_unparent (widget);
            c.children = g_list_remove_link (c.children, children);
            g_list_free (children);
            break;
        }

        children = children.next;
    }
}

extern (C)
void MinWinGtkPeer_forall (GtkContainer *container,
                     gboolean   include_internals,
                     GtkCallback     callback,
                     gpointer            callback_data) {
    MinWinGtkPeer *c;
    GtkWidget *child;
    GList *children;
    c = cast(MinWinGtkPeer*)(container);

    children = c.children;
    while (children) {
        child = cast(GtkWidget*)children.data;
        children = children.next;

        callback(child, callback_data);
    }
}
