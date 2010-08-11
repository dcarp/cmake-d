/* MinWin Component class
 *
 * A Component is the root of the widget inheritance tree.
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.component;

public {
    import minwin.multidg;
    import minwin.geometry;
    import minwin.peer;
}
private {
    import minwin.event;
    import minwin.layout;
    import minwin.logging;
}

abstract class Component {

    // Peer management
    mixin PeerMixin!();

    // disposePeer will dipose of the system resource associated
    // with this object if it owns the peer and the object does
    // not have any parent. It is assumed that an object with a
    // parent will have its peer disposed when the parent is disposed.
    void disposePeer();

    PeerForAdd getPeerForAdd() { return null; }

    void getPeerOffset(inout int x, inout int y) {
        x = 0;
        y = 0;
    }

    void dispose() {
        Component ch = child;
        while (ch !is null) {
            ch.dispose();
            ch = ch.next;
        }
        disposePeer();
    }

    // Name property used for resource lookup on X and debugging
    char[] name;

    // Application data associative array for user data
    void*[char[]] userdata;

    void doCommand(int cmd) {
        if (parent)
            parent.doCommand(cmd);
    }

    void requestFocus() {}

    // size management
    void getMinimumSize(inout int width, inout int height) {
        //todo: ask layout
        width = 0;
        height = 0;
    }
    void getMaximumSize(inout int width, inout int height) {
        //todo: ask layout
        width = int.max;
        height = int.max;
    }
    abstract void getBounds(inout Rect r);
    abstract void setBounds(inout Rect r);
    Rect bounds() {
        Rect r;
        getBounds(r);
        return r;
    }
    void bounds(Rect r) {
        setBounds(r);
    }
    void getLayoutBounds(inout Rect r) {
        Point s = size;
        version(LOG)log.writefln("getLayoutBounds got size %d %d",s.x,s.y);
        r.LTWH(0,0,s.x,s.y);
    }
    void size(Point s);
    Point size() {
        Rect bounds;
        getBounds(bounds);
        version(LOG)log.writefln("size function got width,height %d %d",bounds.width,bounds.height);
        Point res;
        res.x = bounds.width;
        res.y = bounds.height;
        return res;
    }
    int width() {
        Rect bounds;
        getBounds(bounds);
        return bounds.width;
    }
    int height() {
        Rect bounds;
        getBounds(bounds);
        return bounds.height;
    }

    // property to request a particular width no matter what layout
    int userPreferredWidth_data;
    final int userPreferredWidth() { return userPreferredWidth_data; }
    void userPreferredWidth(int width) {
        userPreferredWidth_data = width;
        //        childLayoutDirty = true;
        //        repaint();
    }

    // property to request a particular height no matter what layout
    int userPreferredHeight_data;
    final int userPreferredHeight() { return userPreferredHeight_data; }
    void userPreferredHeight(int height) {
        userPreferredHeight_data = height;
        //        childLayoutDirty = true;
        //        repaint();
    }

    void userPreferredSize(int width, int height) {
        userPreferredHeight = height;
        userPreferredWidth = width;
    }

    Point preferredSize(){
        Point p;
        if (layoutMgr) {
            p = layoutMgr.preferredSize(this);
        }
        if (userPreferredWidth() > 0)
            p.x = userPreferredWidth();
        if (userPreferredHeight() > 0)
            p.y = userPreferredHeight();
        return p;
    }

    // visible property
    void visible(bool vis);
    bool visible();

    // enabled property
    void enabled(bool ena);
    bool enabled();

    Component getRootAncestor() {
        Component top = this;
        while (top.parent !is null) {
            top = top.parent;
        }
        return top;
    }

    // hierarchy management
    Component parent;
    Component child;
    Component next;
    Component prev;

    Component last() {
        return child ? child.prev : null;
    }

    // loop over children
    int opApply(int delegate(inout Component c) dg) {
        int res = 0;
        Component c = child;
        if (c) {
            do {
                res = dg(c);
                c = c.next;
            } while(!res && c !is child);
        }
        return res;
    }

    // link two component as siblings.
    // should an api be exposed to re-arrange without getting the peer?
    void link(Component left, Component right) {
        left.next = right;
        right.prev = left;
    }

    void opCatAssign(Component x) {
        addChild(x);
    }

    void addChild(Component x) {
        x.parent = this;
        if (!child) {
            child = x;
            x.prev = x.next = x;
        } else {
            link(last,x);
            link(x,child);
        }
    }

    void removeChild(Component x) {
        Component old = last;
        if (x is child) {
            if (child is last)
            child = null;
            else
            child = child.next;
        }
        link(x.prev,x.next);
        x.prev = null;
        x.next = null;
        x.parent = null;
    }

    // layout management. TODO: invalidate and repaint on change
    LayoutManager layoutMgr;
    bool childLayoutDirty = true;

    bool parentOwnsLayout_data = true;
    bool parentOwnsLayout() { return parentOwnsLayout_data;    }
    void parentOwnsLayout(bool x) {
        parentOwnsLayout_data = x;
        if (parent) {
            parent.childLayoutDirty = true;
            parent.repaint();
        }
    }

    bool parentOwnsVisibility = true;

    void layout(bool validateParent) {
        if (parent && validateParent)
            parent.layout(true);
        if (childLayoutDirty) {
            if (layoutMgr)
                layoutMgr.layout(this);
            childLayoutDirty = false;
        }
        foreach( Component ch; this) {
            ch.layout(false);
        }
    }

    void pack() {
        int width,height;
        Point s;
        if (layoutMgr) {
            s = layoutMgr.preferredSize(this);
            version(LOG) log.writefln("preferred size %d %d",s.x,s.y);
            size = s;
            childLayoutDirty = true;
            version(LOG) log.printf("in pack about to repaint %x\n",this);
            repaint();
            version(LOG) log.printf("in pack done repaint about to layout %x\n",this);
            layout(false);
            version(LOG) log.printf("in pack done layout %x\n",this);
        }
    }

    // painting and graphics context management
    void repaint() {
        version(LOG) log.printf("in component.repaint for %x\n",this);
        foreach ( Component c; this) {
            version(LOG) log.printf(" repaint for child %x of %x\n",c,this);
            c.repaint();
        }
    }
    bool clearBackgroundOnPaint = true;
    void repaint(inout Rect r) {}
}

class WindowChild : Component {
    WindowChildPeer getPeer() { return null; }
}
