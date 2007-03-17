/* MinWin geometry types
 *
 * Defines Point, Rect, Region and Color and associated functions.
 * These are structs with a single field called "native" that stores
 * the native type or, in the case of color on Unix system, an
 * int with the RGB triple. A Region is a class wrapping a system
 * region resource.
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.geometry;

private {
    import minwin.peer;
    import minwin.app;
    import minwin.logging;
    import std.string;
}

enum FillRule {
    EvenOdd, Winding
}

template CommonPointImpl() {
    PointNative native;
    void x(int v) { native.x = v; }
    int x() { return native.x; }
    void y(int v) { native.y = v; }
    int y() { return native.y; }
    void XY(int x, int y) {
        native.x = x;
        native.y = y;
    }
    Point opAdd(Point b) {
        Point res;
        res.x = x+b.x;
        res.y = y+b.y;
        return res;
    }
    Point opSub(Point b) {
        Point res;
        res.x = x-b.x;
        res.y = y-b.y;
        return res;
    }
    char[] toString() {
        return format("[Point x:%.3d y:%.3d]",x(),y());
    }
}

template CommonRectImpl() {
    RectNative native;
    void translate(Point p) {
        left = left + p.x;
        top = top + p.y;
        right = right + p.x;
        bottom = bottom + p.y;
    }
    char[] toString() {
        return format("[Rect l:%.3d t:%.3d w:%.3d h:%.3d]",left(),top(),width(),height());
    }
    bool contains(Point p) {
        return (p.x >= left) && (p.x <= right) && (p.y >= top) && (p.y <= bottom);
    }
}

template CommonColorImpl() {
    ColorNative native;
    char[] toString() {
        return format("[Color r:%.3d g:%.3d b:%.3d]",red,green,blue);
    }

}

version(GTK)
    version = WidthHeightRect;

version(WidthHeightRect) {
    template WidthHeightRectImpl() {
        void LTWH(int left, int top, int width, int height) {
            native.x = left;
            native.y = top;
            native.width = width;
            native.height = height;
        }
        void LTRB(int left, int top, int right, int bottom) {
            native.x = left;
            native.y = top;
            native.width = right-left;
            native.height = bottom-top;
        }
        int left() { return native.x; }
        int top() { return native.y;    }
        int right() { return native.x + native.width; }
        int bottom() { return native.y + native.height; }
        int width() { return native.width; }
        int height() { return native.height; }
        void left(int v) { native.x = v; }
        void top(int v) { native.y = v; }
        void right(int v) { native.width = v - native.x; }
        void bottom(int v) { native.height = v - native.y; }
        void width(int v) { native.width = v; }
        void height(int v) { native.height = v; }
    }
}
version(GTK)
    version = CommonUnixColor;

// should check x display? RGB masks says red FF0000, blue FF
version(CommonUnixColor) {
    alias uint ColorNative;
    struct Color {
        ColorNative native;
        void RGB(ubyte r, ubyte g, ubyte b) {
            native = ((cast(uint)r)<<16) | ((cast(uint)g)<<8) | (cast(uint)b);
        }
        ubyte red(){ return cast(ubyte)((native & 0x0FF0000)>>16); }
        ubyte green(){ return cast(ubyte)((native & 0x0FF00)>>8); }
        ubyte blue(){ return cast(ubyte)(native & 0x0FF); }
        void red(ubyte r) { native |= ((cast(uint)r)<<16);}
        void green(ubyte g) { native |= ((cast(uint)g)<<8);}
        void blue(ubyte b) { native |= b; }
        package static int rescale(int v, int s1, int s2) {
            double x = 1.0*s2/s1;
            return cast(int)(x*v);
        }
    }
}

version (MinWin32) {
    private import minwin.mswindows;
    private import std.c.stdlib;

    alias POINT PointNative;
    struct Point {
        mixin CommonPointImpl!();
    }

    alias RECT RectNative;
    struct Rect {
        mixin CommonRectImpl!();
        void LTWH(int left, int top, int width, int height) {
            native.left = left;
            native.top = top;
            native.right = left+width;
            native.bottom = top+height;
        }
        void LTRB(int left, int top, int right, int bottom) {
            native.left = left;
            native.top = top;
            native.right = right;
            native.bottom = bottom;
        }
        int left() { return native.left; }
        int top() { return native.top;    }
        int right() { return native.right; }
        int bottom() { return native.bottom; }
        int width() { return native.right - native.left; }
        int height() { return native.bottom - native.top; }
        void left(int v) { native.left = v; }
        void top(int v) { native.top = v; }
        void right(int v) { native.right = v; }
        void bottom(int v) { native.bottom = v; }
        void width(int v) { native.right = native.left + v; }
        void height(int v) { native.bottom = native.top + v; }
    }

    alias COLORREF ColorNative;
    struct Color {
        mixin CommonColorImpl!();
        void RGB(ubyte r, ubyte g, ubyte b) {
            native = std.c.windows.windows.RGB(r,g,b);
        }
        ubyte red(){ return cast(ubyte)(native & 0x0FF); }
        ubyte green(){ return cast(ubyte)((native & 0x0FF00)>>8); }
        ubyte blue(){ return cast(ubyte)((native & 0x0FF0000)>>16); }
        void red(ubyte r) { native |= r; }
        void green(ubyte g) { native |= ((cast(uint)g)<<8);}
        void blue(ubyte b) { native |= ((cast(uint)b)<<16);}
    }

    Color systemBackgroundColor() {
        return toColor(GetSysColor(COLOR_MENU));
    }

    alias HRGN RegionPeer;
    class Region {
        RegionPeer peer;
        mixin SimplePeerMixin!();

        this(inout Rect r) {
            peer = CreateRectRgnIndirect(&r.native);
            sysAssert(peer !is null, "Failed to create peer Region");
            hasPeer = OWNS_PEER;
        }
        this(Point[] pts, FillRule rule = FillRule.Winding) {
            peer = CreatePolygonRgn(cast(POINT*)pts.ptr, pts.length, rule);
            sysAssert(peer !is null, "Failed to create peer polygon Region");
            hasPeer = OWNS_PEER;
        }

        this(RegionPeer rgn) {
            peer = rgn;
            hasPeer = FOREIGN_PEER;
        }
        int opEquals(Object o) {
            Region r = cast(Region)o;
            return r && EqualRgn(peer,r.peer);
        }
        Region unionRgn(Region r) {
            int ok = CombineRgn(peer,peer,r.peer,RGN_OR);
            sysAssert(ok != false, "Failed to combine regions",0);
            return this;
        }
        Region unionRect(inout Rect r) {
            Region rectRgn = new Region(r);
            int ok = CombineRgn(peer,peer,rectRgn.peer,RGN_OR);
            sysAssert(ok != false, "Failed to union regions",0);
            return this;
        }
        Region intersectRgn(Region r) {
            int ok = CombineRgn(peer,peer,r.peer,RGN_AND);
            sysAssert(ok != false, "Failed to intersect regions",0);
            return this;
        }
        bool contains(Point p) {
            return PtInRegion(peer,p.x,p.y) != 0;
        }
        Region dup() {
            RGNDATA* data;
            DWORD siz = GetRegionData(peer,0,null);
            sysAssert(siz != 0, "Failed to get region data size",0);
            data = cast(RGNDATA*)malloc(RGNDATAHEADER.sizeof+siz);
            sysAssert(data !is null, "Failed to malloc region data",0);
            Region r;
            try {
                siz = GetRegionData(peer,siz,data);
                sysAssert(siz != 0, "Failed to get region data",0);
                HRGN p = ExtCreateRegion(null,siz,data);
                sysAssert(p !is null, "Failed to duplicate region",0);
                r = new Region(p);
            } finally {
                free(data);
            }
            return r;
        }
    }

} else version (GTK) {

    private import minwin.gtk;

    alias GdkPoint PointNative;
    struct Point {
        mixin CommonPointImpl!();
    }
    alias GdkRectangle RectNative;
    struct Rect {
        mixin CommonRectImpl!();
        mixin WidthHeightRectImpl!();
    }

    GdkColor* toNativeColor(Color c) {
        GdkColor* r = new GdkColor;
        r.red = Color.rescale(c.red,ubyte.max,ushort.max);
        r.green = Color.rescale(c.green,ubyte.max,ushort.max);
        r.blue = Color.rescale(c.blue,ubyte.max,ushort.max);
        version(LOG)log.writefln("rescaled color %x %x %x to %x %x %x",
                     cast(int)c.red,cast(int)c.green,cast(int)c.blue,
                     cast(int)r.red,cast(int)r.green,cast(int)r.blue);
        return r;
    }

    Color systemBackgroundColor() {
        GtkStyle* style = gtk_widget_get_default_style();
        GdkColor* c = &style.bg[GtkStateType.GTK_STATE_NORMAL];
        ubyte r = Color.rescale(c.red,ushort.max,ubyte.max);
        ubyte g = Color.rescale(c.green,ushort.max,ubyte.max);
        ubyte b = Color.rescale(c.blue,ushort.max,ubyte.max);
        Color c2;
        c2.RGB(r,g,b);
        return c2;
    }

    alias GdkRegion* RegionPeer;

    class Region {
        RegionPeer peer;

        mixin PeerMixin!();
        void dispose() { disposePeer(); }
        void disposePeer() {
            if (hasPeer == OWNS_PEER) {
                gdk_region_destroy(peer);
            }
            hasPeer = NO_PEER;
        }

        this(inout Rect r) {
            peer = gdk_region_new();
            gdk_region_union_with_rect(peer,&r.native);
            hasPeer = OWNS_PEER;
        }

        this(Point[] pts, FillRule rule = FillRule.Winding) {
            peer = gdk_region_polygon(cast(GdkPoint*)pts.ptr, pts.length,
                cast(GdkFillRule)rule);
            hasPeer = OWNS_PEER;
        }

        this(RegionPeer rgn) {
            peer = rgn;
            hasPeer = FOREIGN_PEER;
        }

        int opEquals(Object o) {
            Region r = cast(Region)o;
            return r && gdk_region_equal(peer,r.peer);
        }
        Region unionRgn(Region r) {
            gdk_region_union(peer,r.peer);
            return this;
        }
        Region unionRect(inout Rect r) {
            gdk_region_union_with_rect(peer,&r.native);
            return this;
        }
        Region intersectRgn(Region r) {
            gdk_region_intersect(peer,r.peer);
            return this;
        }
        bool contains(Point p) {
            return gdk_region_point_in(peer,p.x,p.y) != 0;
        }
        Region dup() {
            GdkRegion* r = gdk_region_new();
            gdk_region_union(r,peer);
            Region mwr = new Region(r);
            mwr.hasPeer = OWNS_PEER;
            return mwr;
        }
    }
}

Point toPoint(PointNative nat) {
    Point r;
    r.native = nat;
    return r;
}
Point XY(int x, int y) {
    Point p;
    p.XY(x,y);
    return p;
}

Rect toRect(RectNative nat) {
    Rect r;
    r.native = nat;
    return r;
}

Rect LTWH(int left, int top, int width, int height) {
    Rect r;
    r.LTWH(left,top,width,height);
    return r;
}

Rect LTRB(int left, int top, int right, int bottom) {
    Rect r;
    r.LTRB(left,top,right,bottom);
    return r;
}

Color toColor(ColorNative nat) {
    Color r;
    r.native = nat;
    return r;
}
Color RGB(ubyte r, ubyte g, ubyte b) {
    Color res;
    res.RGB(r,g,b);
    return res;
}


private {
    final int max(int a,int b){ return a>b?a:b; }
    final int min(int a,int b){ return a<b?a:b; }
}

void intersectRect(inout Rect res, inout Rect r1, inout Rect r2) {
    int l,t,r,b;
    l = max(r1.left,r2.left);
    t = max(r1.top,r2.top);
    r = min(r1.right,r2.right);
    b = min(r1.bottom,r2.bottom);
    if (l>r || t>b) {
        res.LTRB(0,0,0,0);
    } else {
        res.LTRB(l,t,r,b);
    }
}
void unionRect(inout Rect res, inout Rect r1, inout Rect r2) {
    int l,t,r,b;
    l = min(r1.left,r2.left);
    t = min(r1.top,r2.top);
    r = max(r1.right,r2.right);
    b = max(r1.bottom,r2.bottom);
    res.LTRB(l,t,r,b);
}
void offsetRect(inout Rect res, int x, int y) {
    res.LTWH(res.left+x,res.top+y,res.width,res.height);
}

// Region unittests
unittest {
    Rect r = LTWH(10,10,100,100);
    Region rgn = new Region(r);
    assert(rgn.contains(XY(50,50)));
    assert(!rgn.contains(XY(0,50)));

    Rect r2 = LTWH(-10,10,40,60);
    rgn.unionRect(r2);
    assert(rgn.contains(XY(0,50)));

    Region rgn2 = rgn.dup;
    assert(rgn == rgn2);
    assert(rgn !is rgn2);

    Point[] x;
    x.length = 5;
    x[0].XY(0,-10);
    x[1].XY(100,100);
    x[2].XY(0,200);
    x[3].XY(-100,100);
    x[4].XY(0,-10);
    rgn2.intersectRgn(new Region(x));
    assert(rgn2.contains(XY(0,50)));
}

// Color unittests
unittest {
    Color c = RGB(30,40,60);
    assert(c.red == 30);
    assert(c.green == 40);
    assert(c.blue == 60);
}

// Rect unittests
unittest {
    Rect r1 = LTWH(10,20,100,200);
    assert(r1.left == 10);
    assert(r1.top == 20);
    assert(r1.width == 100);
    assert(r1.height == 200);
    assert(r1.right == 110);
    assert(r1.bottom == 220);
    r1.LTWH(-10,-20,10,20);
    assert(r1.right == 0);
    assert(r1.bottom == 0);
    r1.LTRB(-10,-20,10,20);
    assert(r1.right == 10);
    assert(r1.bottom == 20);
    assert(r1.width == 20);
    assert(r1.height == 40);
    Rect r5;
    r5.left = -10;
    r5.top = -20;
    r5.width = 30;
    r5.height = 50;
    assert(r5.left == -10);
    assert(r5.top == -20);
    assert(r5.right == 20);
    assert(r5.bottom == 30);

    Rect r2 = LTRB(-10,-20,10,20);
    assert(r1 == r2);

    Rect r3;
    r2.LTWH(0,5,20,20);
    intersectRect(r3,r1,r2);
    assert(r3 == LTRB(0,5,10,20));
    Rect r4 = LTWH(-100,-100,300,300);
    intersectRect(r3,r1,r4);
    assert(r3 == r1);
    intersectRect(r3,r4,r1);
    assert(r3 == r1);

    r4.LTWH(0,0,100,10);
    unionRect(r3,r4,r1);
    assert(r3 == LTRB(-10,-20,100,20));

    offsetRect(r4,10,20);
    assert(r4 == LTWH(10,20,100,10));
}

// Point unittests
unittest {
    Point p = XY(100,200);
    assert(p.x == 100);
    assert(p.y == 200);
    p.XY(300,-400);
    assert(p.x == 300);
    assert(p.y == -400);
    // try platform-specific properties that happen to work
    assert(p.native.x == 300);
    assert(p.native.y == -400);

    assert(p == XY(300,-400));

    Rect r = LTWH(10,20,300,400);
    assert(r.contains(XY(200,300)));
    assert(r.contains(XY(10,200)));
    assert(r.contains(XY(10,420)));
    assert(!r.contains(XY(0,200)));
    assert(!r.contains(XY(200,1000)));
}

