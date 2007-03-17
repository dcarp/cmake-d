/* MinWin Layout management
 *
 * Defines a LayoutManager interface and some layout managers
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.layout;

public import minwin.component;

private import minwin.logging;

interface LayoutManager {

    // layout children of c. Can reuse cached information from previous
    // preferredSize() or layout() calls in which case the layout
    // manager should only be used for a single component.
    void layout(Component c);

    // compute preferred layout size. Does not reuse cached information.
    Point preferredSize(Component c);

    // clear cache if present
    void reset();
}

/*****************    Flow Layout *********************/
enum Dir {
    Horizontal, // left to right, then right to left
    Vertical        // top to bottom, then bottom to top
}

class FlowLayout : LayoutManager {
    Dir dir;

    int flowGap;     // gap between items along flow direction
    int flowReverse = 1000; // number of items to lay out before
    // flipping to the other side
    double endGap = 0.0; // gap at ends of layout, values <= 1 are
                                             // percentage of space

    int sideGap;     // gap between largest item and side
    bool sideStretch; // true means items are stretched to fit to side

    int prefWidth;
    int prefHeight;

    this(Dir dir = Dir.Vertical) {
        this.dir = dir;
        prefWidth = -1;
        prefHeight = -1;
    }

    void layout(Component c) {
        Rect r;
        if (c.child is null) return;
        version(LOG) log.printf("laying out %x\n",c);
        c.getLayoutBounds(r);
        version(LOG) log.writefln("layout got bounds %d %d %d %d",
                        r.left,r.top,r.width,r.height);
        int width = r.width;
        int height = r.height;
        if (prefWidth < 0) {
            Point s = preferredSize(c);
            prefWidth = s.x;
            prefHeight = s.y;
        }
        int actEndGap = cast(int)endGap; // actual end gap in pixels
        int actFlowGap = flowGap;
        int x = r.left;
        int y = r.top;
        int left = x;
        int top = y;
        int bottom = r.bottom;
        int right = r.right;
        if (dir == Dir.Vertical) {
            if (endGap <= 1.0)
                actEndGap = cast(int)(endGap*(height - prefHeight)/2);
            y += actEndGap;
        } else {
            if (endGap <= 1.0)
                actEndGap = cast(int)(endGap*(width - prefWidth)/2);
            x += actEndGap;
        }
        int n = 0;
        bool isVisible = c.visible();
        foreach (Component ch; c ) {
            int w, h;
            version(LOG) log.printf("doing flow layout for child %x\n",ch);
            if (n == flowReverse) {
                if (dir == Dir.Vertical)
                    y = top + height - actEndGap;
                else
                    x = left + width - actEndGap;
                actFlowGap = -actFlowGap;
            }
            if (ch.parentOwnsLayout) {
                Point s = ch.preferredSize();
                w = s.x;
                h = s.y;
                version(LOG) log.printf(" got flow child size for %x\n",ch);
                if (dir == Dir.Vertical) {
                    if (n != 0 && n < flowReverse) y += flowGap; // what about first item?
                    if (n >= flowReverse) y -= h;
                    int x1 = x, w1 = width;
                    if (!sideStretch && (w < width)) {
                        x1 = x+(width-w)/2;
                        w1 = w;
                    }
                    r.LTWH(x1,y,w1,h);
                    if ((r.top > bottom || r.bottom < top) && ch.parentOwnsVisibility) {
                        version(LOG)log.printf("layout setting visible off on %x %d %d\n",
                                 ch,r.bottom,height);
                        ch.visible = false;
                    } else {
                        version(LOG)log.writefln("about to set bounds on child %s",
                                     ch.classinfo.name);
                        ch.setBounds(r);
                        version(LOG)log.printf("layout checking for visible on %x\n",ch);
                        if (ch.parentOwnsVisibility && isVisible) {
                            version(LOG)log.printf("layout setting visible on %x\n",ch);
                            ch.visible = true;
                        }
                        ch.layout(false);
                    }
                    if (n < flowReverse) y += h;
                } else {
                    if (n < flowReverse) x += flowGap;
                    if (n >= flowReverse) x -= w;
                    int y1 = y, h1 = height;
                    if (!sideStretch && (h < height)) {
                        y1 = y+(height-h)/2;
                        h1 = h;
                    }
                    r.LTWH(x,y1,w,h1);
                    if ((r.left > right || r.right < left) && ch.parentOwnsVisibility) {
                        version(LOG)log.printf("layout setting visible off on %x\n",ch);
                        ch.visible = false;
                    } else {
                        ch.setBounds(r);
                        if (ch.parentOwnsVisibility && isVisible)
                            ch.visible = true;
                        ch.layout(false);
                    }
                    if (n < flowReverse) x += w;
                }
            }
            ++n;
        }
        version(LOG) log.printf(" done laying out %x\n",c);
    }

    Point preferredSize(Component c) {
        version(LOG) log.printf("preferred size for %x\n",c);
        int width = 0;
        int height = 0;
        foreach (Component ch; c ) {
            int w, h;
            if (ch.parentOwnsLayout) {
                Point s = ch.preferredSize;
                w = s.x;
                h = s.y;
                if (dir == Dir.Vertical) {
                    height += flowGap;
                    width = width < w ? w : width;
                    height += h;
                } else {
                    width += flowGap;
                    height = height < h ? h : height;
                    width += w;
                }
            }
        }
        if (dir == Dir.Vertical) {
            height += 2*cast(int)endGap;
            width += 2*sideGap;
        } else {
            width += 2*cast(int)endGap;
            height += 2*sideGap;
        }
        prefWidth = width;
        prefHeight = height;
        version(LOG) log.printf(" done preferred size for %x %d %d\n",c,width,height);
        return XY(width,height);
    }

    void reset() {
        prefWidth = -1;
        prefHeight = -1;
    }
}

/*****************    Table Layout *********************/

// A TableLayout first computes the sum of all the preferred
// sizes of the rows and columns and then divides up the remaining
// space according to the user-supplied distribution. If the
// preferred sizes are greater then the available space the
// preferred sizes are shrunk by the user-supplied distribution to fit
class TableLayout : LayoutManager {

    double[] rowScales;
    double[] colScales;
    int gap;

    bool cache;
    double[] prows; // preferred row heights
    double[] pcols; // preferred column widths

    double[] arows; // actual row heights
    double[] acols; // actual column widths

    // constructs a TableLayout with given scales. The scale
    // arrays are duplicated.
    this(double[] colScales, double[] rowScales, int gap = 0) {
        this.rowScales = rowScales.dup;
        this.colScales = colScales.dup;
        this.gap = gap;
        reset();
    }

    void reset() {
        prows.length = rowScales.length;
        pcols.length = colScales.length;
        prows[] = 0;
        pcols[] = 0;
        arows.length = rowScales.length;
        acols.length = colScales.length;
        cache = false;
    }

    void layout(Component comp) {
        int r,c;
        int pref_width, pref_height;
        if (comp.child is null) return;
        version(LOG) log.printf("laying out %x\n",comp);
        if (!cache)
            fillPreferredData(comp);
        computePreferredSize(comp,pref_width,pref_height);
        Rect b,pb;
        version(LOG) log.printf("about to get bounds of comp %x\n",comp);
        comp.getLayoutBounds(pb);
        version(LOG) log.writefln("layout got bounds %d %d %d %d",
                        pb.left,pb.top,pb.width,pb.height);
        int width = pb.width;
        int height = pb.height;

        // distribute extra space or trim to fit in given space
        int extra_width = width - pref_width;
        int extra_height = height - pref_height;
        version(LOG) log.writefln("extra %d %d \n",extra_width,extra_height);
        foreach(int n, double x; prows) {
            arows[n] = x + rowScales[n]*extra_height;
            version(LOG) log.writefln("rows[n] %g",arows[n]);
        }
        double total = 0;
        foreach(int n, double x; arows) {
            total += x;
            arows[n] = cast(int)total;
        }
        foreach(int n, double x; pcols) {
            acols[n] = x + colScales[n]*extra_width;
            version(LOG) log.writefln("cols[n] %g",acols[n]);
        }
        total = 0;
        foreach(int n, double x; acols) {
            total += x;
            acols[n] = cast(int)total;
        }
        int x,y;
        c = 0;
        r = 0;
        foreach (Component ch; comp ) {
            if (ch.parentOwnsLayout) {
                int nx = cast(int)acols[c];
                int ny = cast(int)arows[r];
                version(LOG) log.writefln("nx ny %d %d",nx,ny);
                b.LTRB(pb.left+x,pb.top+y,nx,ny);
                x = nx;
                version(LOG) log.printf("setting bounds of %x during layout for %x\n",ch,comp);
                ch.setBounds(b);
                version(LOG) log.printf("child layout %x during layout for %x\n",ch,comp);
                ch.layout(false);
                if (++c >= colScales.length) {
                    c = 0;
                    x = 0;
                    y = ny;
                    if (++r >= rowScales.length)
                        break; // just stop if too many children
                }
            }
        }
        version(LOG) log.printf(" done laying out %x\n",comp);
    }

    Point preferredSize(Component comp) {
        int width,height;
        version(LOG) log.printf("preferred size for %x\n",comp);
        fillPreferredData(comp);
        computePreferredSize(comp,width,height);
        version(LOG) log.printf(" done preferred size for %x\n",comp);
        return XY(width,height);
    }

    private void fillPreferredData(Component comp) {
        int r,c;
        prows[] = 0;
        pcols[] = 0;
        foreach (Component ch; comp ) {
            int w, h;
            if (ch.parentOwnsLayout) {
                Point s = ch.preferredSize;
                w = s.x;
                h = s.y;
                version(LOG) log.writefln("pref size %d %d",w,h);
                prows[r] = prows[r]>h ? prows[r] : h;
                pcols[c] = pcols[c]>w ? pcols[c] : w;
                version(LOG) log.writefln("row col %g %g",prows[r],pcols[c]);
                if (++c >= colScales.length) {
                    c = 0;
                    if (++r >= rowScales.length)
                        break; // just stop if too many children
                }
            }
        }
        cache = true;
    }

    private void computePreferredSize(Component comp,
                        inout int width,
                        inout int height) {
        double total = 0;
        foreach(double x; pcols) { total += x; }
        width = cast(int)total;
        total = 0;
        foreach(double x; prows) { total += x; }
        height = cast(int)total;
    }
}

/*****************    Border Layout *********************/

/*

    ---------------
    |            N            |
    |-------------|
    |    |             |    |
    |W |     C     | E|
    |    |             |    |
    |-------------|
    |            S            |
    ---------------

*/

enum Loc {
    North, South, East, West, Center
}

class BorderLayout : LayoutManager {
    Component[Loc.max+1] location; // user fills this in

    void layout(Component c) {
        Rect r;
        if (c.child is null) return;
        c.getLayoutBounds(r);
        version(LOG) log.writefln("layout got bounds %d %d %d %d",
                r.left,r.top,r.width,r.height);
        int width = r.width;
        int height = r.height;
        int west,east,north,south;
        int dummy;
        if (location[Loc.North])
            north = location[Loc.North].preferredSize().y;
        if (location[Loc.South])
            south = location[Loc.South].preferredSize().y;
        if (location[Loc.East])
            east = location[Loc.East].preferredSize().x;
        if (location[Loc.West])
            west = location[Loc.West].preferredSize().x;
        Rect cr;
        int x0 = r.left;
        int y0 = r.top;
        // TODO: visible off if not enough space
        if (location[Loc.North]) {
            cr.LTWH(x0,y0,r.width,north);
            location[Loc.North].setBounds(cr);
        }
        if (location[Loc.South]) {
            cr.LTWH(x0,y0+r.height-south,r.width,south);
            location[Loc.South].setBounds(cr);
        }
        if (location[Loc.West]) {
            cr.LTWH(x0,y0+north,west,r.height-south-north);
            location[Loc.West].setBounds(cr);
        }
        if (location[Loc.East]) {
            cr.LTWH(x0+r.width-east,y0+north,east,r.height-south-north);
            location[Loc.East].setBounds(cr);
        }
        if (location[Loc.Center]) {
            cr.LTWH(x0+west,y0+north,width-east-west,height-south-north);
            location[Loc.Center].setBounds(cr);
        }
    }

    Point preferredSize(Component c) {
        int width = 0;
        int height = 0;
        int west,east,north,south,centerWidth,centerHeight;
        int dummy;
        Point center;
        Point eastPt;
        Point westPt;
        if (location[Loc.North])
            north = location[Loc.North].preferredSize().y;
        if (location[Loc.South])
            south = location[Loc.South].preferredSize().y;
        if (location[Loc.East])
            eastPt = location[Loc.East].preferredSize();
        if (location[Loc.West])
            westPt = location[Loc.West].preferredSize();
        if (location[Loc.Center])
            center = location[Loc.Center].preferredSize;
        east = eastPt.x;
        west = westPt.x;
        int maxy = eastPt.y>westPt.y?eastPt.y:westPt.y;
        maxy = maxy>center.y?maxy:center.y;
        width = east + west + center.x;
        height = north + south + maxy;
        version(LOG)log.writefln("BorderLayout preferred size %d %d",width,height);
        return XY(width,height);
    }

    void reset() {    }
}

unittest {
    // simple component for testing layout
    class Foo : Component {
        Rect bounds;
        this(Component parent) {
            if (parent)
                parent.addChild(this);
        }
        void disposePeer(){}
        PeerForAdd getPeerForAdd() {return parent.getPeerForAdd();}
        void getPeerOffset(inout int x, inout int y) {}
        void getBounds(inout Rect r) { r = bounds; }
        void setBounds(inout Rect r) {
            bounds = r;
            childLayoutDirty = true;
        }
        void size(Point s) {
            bounds.LTWH(bounds.left,bounds.top,s.x,s.y);
            childLayoutDirty = true;
        }
        void visible(bool vis) { }
        bool visible() { return true; }
        void repaint() { }
    }
    Foo a = new Foo(null);
    Foo c1 = new Foo(a);
    Foo c2 = new Foo(a);
    Foo c3 = new Foo(a);

}
