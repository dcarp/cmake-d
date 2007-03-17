/* MinWin Paint module
 *
 * An GContext is a simple 2D drawing API similar to a Windows DC
 * and an X11 Graphics Context. A GXContext is a more advanced
 * painting API that is similar to GDI+ or Quartz.
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.paint;

public {
    import minwin.geometry;
    import minwin.peer;
}

private {
    import minwin.app;
    import minwin.image;
    import minwin.logging;
}

// TODO: gdi+
//    maybe also add a template paint context with coordinates in non-int

GContext newGContext() {
    GContext gc = GContext.freeList;
    if (gc) {
        GContext.freeList = GContext.freeList.next;
    } else {
        gc = new GContext;
    }
    return gc;
}

enum PenStyle {
    Solid =                        0,
    Dash =                         1, /* -------    */
    Dot =                            2, /* .......    */
    DashDot =                    3    /* _._._._    */
    // todo: None?
}

enum LineJoin {
    Round,
    Bevel,
    Miter
}

enum PaintMode {
    Copy, Invert, And, Or, Xor
}

version (GTK)
    version = SharedPenBrushImpl;

version (SharedPenBrushImpl) {

    struct PenData {
        uint width;
        Color color;
        PenStyle style;
        LineJoin join;

    }

    class Pen {
        PenData data;
        this(PenData* data) {
            this.data = *data;
        }
        this(Color color) {
            data.color = color;
        }
        void dispose(){}
    }

    class Brush {
        Color color;
        this(Color color) {
            this.color = color;
        }
    }
}

version (MinWin32) {
    private import minwin.mswindows;

    public import minwin.font;

    alias HDC GContextPeer;

    class GXContext { } // GDI+

    alias HPEN PenPeer;
    alias HBRUSH BrushPeer;

    private DWORD paintModeToNative(PaintMode mode) {
        DWORD nmode;
        switch (mode) {
            case PaintMode.Copy: nmode = SRCCOPY; break;
            case PaintMode.Invert: nmode = NOTSRCCOPY; break;
            case PaintMode.And: nmode = SRCAND; break;
            case PaintMode.Or: nmode = SRCPAINT; break;
            case PaintMode.Xor: nmode = SRCINVERT; break;
            default: assert(0);
        }
        return nmode;
    }

    struct PenData {
        LOGPEN native;
        void width(uint w) {
            native.lopnWidth = XY(w,w).native;
        }
        void color(Color c) {
            native.lopnColor = c.native;
        }
        void style(PenStyle s) {
            native.lopnStyle = s;
        }
        void lineJoin(LineJoin j) {
        }
    }

    class Pen {
        PenPeer peer;

        mixin SimplePeerMixin!();
        this(PenData* data) {
            peer = CreatePenIndirect(&data.native);
            sysAssert(peer !is null, "Failed to create pen");
            hasPeer = OWNS_PEER;
        }
        this(Color color) {
            PenData pd;
            pd.color = color;
            this(&pd);
        }
        this(PenPeer peer) {
            this.peer = peer;
            hasPeer = FOREIGN_PEER;
        }
    }

    class Brush {
        BrushPeer peer;

        mixin SimplePeerMixin!();
        this(Color color) {
            peer = CreateSolidBrush(color.native);
            sysAssert(peer !is null, "Failed to create brush");
            hasPeer = OWNS_PEER;
        }
        this(BrushPeer peer) {
            this.peer = peer;
            hasPeer = FOREIGN_PEER;
        }
    }

    class GContext {
        GContextPeer peer;
        GContext next; // free list link
        static GContext freeList;
        bool release;
        HWND hwnd; // companion hwnd used if release is true
        Font font;
        FontPeer origFont; // stores font in used before setFont is called
        Pen pen;
        PenPeer origPen;
        Brush brush;
        BrushPeer origBrush;
        Region cliprgn;
        PAINTSTRUCT paintstruct;

        ~this() {
            disposePeer();
        }
        int hasPeer;
        void dispose() {
            disposePeer();
            next = freeList;
            freeList = this;
        }
        void disposePeer() {
            pen = null;
            font = null;
            origFont = origPen = origBrush = null;
            brush = null;
            cliprgn = null;
            if (hasPeer == OWNS_PEER) {
                if (release)
                    ReleaseDC(hwnd,peer);
                else {
                    BOOL ok = DeleteDC(peer);
                    sysAssert(ok != false, "Failed to delete DC");
                }
            }
        }

        Rect updateRect() {
            return toRect(paintstruct.rcPaint);
        }

        Font setFont(Font f) {
            Font oldFont = font;
            font = f;
            if (f is null) {
                SelectObject(peer, cast(HGDIOBJ) origFont);
            } else if (oldFont is null) {
                origFont = cast(FontPeer)SelectObject(peer, cast(HGDIOBJ) font.peer);
            } else {
                SelectObject(peer, cast(HGDIOBJ) font.peer);
            }
            return oldFont;
        }

        void getFontMetrics(inout FontMetrics f) {
            BOOL ok = GetTextMetricsA(peer,&f.native);
            sysAssert(ok != false, "Failed to get font metrics");
        }

        Pen setPen(Pen p) {
            Pen oldPen = pen;
            pen = p;
            if (p is null) {
                SelectObject(peer, cast(HGDIOBJ) origPen);
            } else if (oldPen is null) {
                origPen = cast(PenPeer)SelectObject(peer, cast(HGDIOBJ) pen.peer);
            } else {
                SelectObject(peer, cast(HGDIOBJ) pen.peer);
            }
            return oldPen;
        }

        Brush setBrush(Brush p) {
            Brush oldBrush = brush;
            brush = p;
            if (p is null) {
                SelectObject(peer, cast(HGDIOBJ) origBrush);
            } else if (oldBrush is null) {
                origBrush = cast(BrushPeer)SelectObject(peer, cast(HGDIOBJ) brush.peer);
            } else {
                SelectObject(peer, cast(HGDIOBJ) brush.peer);
            }
            return oldBrush;
        }

        void getClip(Region rgn) {
            int res = GetClipRgn(peer,rgn.peer);
            sysAssert(res != -1, "Failed to get clip region");
        }

        // in postscript could mean intersect with current clip region
        void setClip(Region rgn) {
            int res = SelectClipRgn(peer,rgn.peer);
            sysAssert(res != 0, "Failed to set clip region");
        }

        // pen must be set
        void drawRect(inout Rect r) {
            // TODO: move in by pen width
            BOOL ok = MoveToEx(peer,r.left,r.top,null);
            sysAssert(ok != false, "Failed to draw rect");
            LineTo(peer,r.left,r.bottom-1);
            LineTo(peer,r.right-1,r.bottom-1);
            LineTo(peer,r.right-1,r.top);
            LineTo(peer,r.left,r.top);
        }

        // brush must be set
        void fillRect(inout Rect r) {
            sysAssert(brush !is null, "Brush must be set for fillRect");
            int ok = FillRect(peer,&r.native,brush.peer);
            sysAssert(ok != false, "Failed to fill rect");
        }

        void drawText(int x, int y, char[] str) {
            BOOL ok;
            if (useWfuncs) {
                wchar[] buf = toUTF16(str);
                ok = TextOutW(peer, x, y, buf.ptr, buf.length);
            }
            else {
                auto buf = toMBSz(str);
                ok = TextOutA(peer, x, y, buf, std.c.string.strlen(buf));
            }
            sysAssert(ok != false, "Failed to draw text");
        }
        void drawLine(int x1, int y1, int x2, int y2) {
            BOOL ok = MoveToEx(peer,x1,y1,null);
            sysAssert(ok != false, "Failed to draw line");
            LineTo(peer,x2,y2);
        }
        void drawPolyline(Point[] pts) {
            if (pts.length > 1) {
                BOOL ok = MoveToEx(peer,pts[0].x,pts[0].y,null);
                sysAssert(ok != false, "Failed to draw polyline");
                for (int n=1; n < pts.length; ++n) {
                    LineTo(peer,pts[n].x,pts[n].y);
                }
            }
        }
        void drawPolygon(Point[] pts) {
            if (pts.length > 1) {
                BOOL ok = MoveToEx(peer,pts[0].x,pts[0].y,null);
                sysAssert(ok != false, "Failed to draw polygon");
                for (int n=1; n < pts.length; ++n) {
                    LineTo(peer,pts[n].x,pts[n].y);
                }
                LineTo(peer,pts[0].x,pts[0].y);
            }
        }
        void drawBezier(Point[] pts) {
//            PolyBezier(peer,pts.ptr,pts.length);
        }
        void fillPolygon(Point[] pts) {
            //?
        }
        void fillRegion(Region rgn) {
            sysAssert(brush !is null, "Brush must be set for fillRect");
//            FillRgn(peer,rgn,brush);
        }
        void drawRegion(Region rgn) {
            BOOL ok = PaintRgn(peer,rgn.peer);
            sysAssert(ok != false, "Failed to draw region");
        }

        void drawImage(Image im, int x, int y, PaintMode mode = PaintMode.Copy) {
            HDC memDC = CreateCompatibleDC(peer);
            sysAssert(memDC !is null, "Failed to create compatible DC in drawImage");
            HANDLE res = SelectObject(memDC,im.peer);
            sysAssert(res !is null, "Failed to select bitmap in drawImage");
            version(LOG)log.writefln("drawing image %x %d %d",
                    im,im.width,im.height);
            DWORD nmode = paintModeToNative(mode);
            BOOL ok = BitBlt(peer,x,y,im.width,im.height,memDC,0,0,nmode);
            sysAssert(ok != false, "Failed to BitBlt drawImage");
            version(LOG)log.writefln(" result %d",cast(int)res);
            ok = DeleteDC(memDC);
            sysAssert(ok != false, "Failed to delete compatible DC in drawImage");
        }

        void stretchImage(Image im, int x, int y,
                    int w, int h, PaintMode mode = PaintMode.Copy) {
            HDC memDC = CreateCompatibleDC(peer);
            sysAssert(memDC !is null, "Failed to create compatible DC in stretchImage");
            SelectObject(memDC,im.peer);
            DWORD nmode = paintModeToNative(mode);
            BOOL ok = StretchBlt(peer,x,y,w,h,memDC,0,0,im.width,im.height,nmode);
            sysAssert(ok != false, "Failed to StretchBlt in stretchImage");
            DeleteDC(memDC);
        }

        void drawSubImage(Image im, int x, int y,
                    int sx, int sy, int sw, int sh,
                    PaintMode mode = PaintMode.Copy) {
            HDC memDC = CreateCompatibleDC(peer);
            sysAssert(memDC !is null, "Failed to create compatible DC in drawSubImage");
            SelectObject(memDC,im.peer);
            DWORD nmode = paintModeToNative(mode);
            BOOL ok = BitBlt(peer,x,y,sw,sh,memDC,sx,sx,nmode);
            sysAssert(ok != false, "Failed to BitBlt in drawSubImage");
            DeleteDC(memDC);
        }

        void stretchSubImage(Image im, int x, int y, int w, int h,
             int sx, int sy, int sw, int sh,
             PaintMode mode = PaintMode.Copy) {
            HDC memDC = CreateCompatibleDC(peer);
            sysAssert(memDC !is null, "Failed to create compatible DC in stretchSubImage");
            SelectObject(memDC,im.peer);
            DWORD nmode = paintModeToNative(mode);
            BOOL ok = StretchBlt(peer,x,y,w,h,memDC,sx,sy,sw,sh,nmode);
            sysAssert(ok != false, "Failed to StretchBlt in stretchSubImage");
            DeleteDC(memDC);
        }

        void flush() {
            GdiFlush();
        }
    }

} else version (GTK) {

    private import minwin.gtk;

    public import minwin.font;

    private GdkFunction paintModeToNative(PaintMode mode) {
        GdkFunction nmode;
        switch (mode) {
            case PaintMode.Copy: nmode = GdkFunction.GDK_COPY; break;
            case PaintMode.Invert: nmode = GdkFunction.GDK_COPY_INVERT; break;
            case PaintMode.And: nmode = GdkFunction.GDK_AND; break;
            case PaintMode.Or: nmode = GdkFunction.GDK_OR; break;
            case PaintMode.Xor: nmode = GdkFunction.GDK_XOR; break;
            default: assert(0);
        }
        return nmode;
    }

    alias GdkGC* GContextPeer;

    class GXContext { } // not impl in GDK

    class GContext {
        GContextPeer peer;
        GContext next; // free list link
        static GContext freeList;
        GdkDrawable* drawable;
        PangoLayout* layout;
        Font font;
        Pen pen;
        Brush brush;
        bool penActive;
        GdkEventExpose* paintEvent;

        ~this() {
            disposePeer();
        }
        int hasPeer;
        void dispose() {
            disposePeer();
            next = freeList;
            freeList = this;
        }
        void disposePeer() {
            pen = null;
            font = null;
            brush = null;
            penActive = false;
            if (hasPeer == OWNS_PEER) {
                g_object_unref(cast(GObject*)peer);
                //  g_object_unref(cast(GObject*)layout);
            }
        }

        Rect updateRect() {
            Rect r;
            if (paintEvent)
                r = toRect(paintEvent.area);
            return r;
        }

        Font setFont(Font f) {
            Font oldFont = font;
//          if (oldFont is null)
//              oldFont = DefaultFont;
            font = f;
            if (font)
                pango_layout_set_font_description(layout,font.peer);
            return oldFont;
        }

        void getFontMetrics(inout FontMetrics f) {
            PangoContext* c = pango_layout_get_context(layout);
            PangoFontMetrics* data = pango_context_get_metrics(c,font.peer,null);
            f.ascent = pango_font_metrics_get_ascent(data);
            f.descent = pango_font_metrics_get_descent(data);
            //            f.leading = f.descent;
            f.leading = 0;
            f.size = f.ascent+f.descent;
            f.maxWidth = pango_font_metrics_get_approximate_char_width(data)/PANGO_SCALE;
            f.size /= PANGO_SCALE;
            f.ascent /= PANGO_SCALE;
            f.descent /= PANGO_SCALE;
            f.leading /= PANGO_SCALE;
            pango_font_metrics_unref(data);
        }

        private void setForeground(Color rgb) {
            GdkColor c;
            c.red = Color.rescale(rgb.red,ubyte.max,ushort.max);
            c.green = Color.rescale(rgb.green,ubyte.max,ushort.max);
            c.blue = Color.rescale(rgb.blue,ubyte.max,ushort.max);
            gdk_gc_set_rgb_fg_color(peer,&c);
        }

        Pen setPen(Pen p) {
            Pen oldPen = pen;
            pen = p;
            if (p !is null) {
                GdkLineStyle style = GdkLineStyle.GDK_LINE_SOLID;
                if (p.data.style != PenStyle.Solid) {
                    style = GdkLineStyle.GDK_LINE_ON_OFF_DASH;
                    gdk_gc_set_dashes(peer,0,dashlist[style-1].ptr,
                             dashlist[style-1].length);
                }
                gdk_gc_set_line_attributes(peer,p.data.width,style,
                                 GdkCapStyle.GDK_CAP_BUTT,
                                 cast(GdkJoinStyle)p.data.join);
                setForeground(p.data.color);
                penActive = true;
            }
            return oldPen;
        }

        Brush setBrush(Brush p) {
            Brush oldBrush = brush;
            brush = p;
            if (brush) {
                setForeground(brush.color);
                penActive = false;
            }
            return oldBrush;
        }

        void drawRect(inout Rect r) {
            if (pen && !penActive) {
                setForeground(pen.data.color);
                penActive = true;
            }
            gdk_draw_rectangle(drawable,peer,false,
                 r.left,r.top,r.width-1,r.height-1);
        }

        // brush must be set
        void fillRect(inout Rect r) {
            if (brush && penActive) {
                setForeground(brush.color);
                penActive = false;
            }
            gdk_draw_rectangle(drawable,peer,true,
                 r.left,r.top,r.width,r.height);
        }

        private static {
            byte[][3] dashlist;
            byte[2] dashed = [6,6];
            byte[2] dotted = [4,2];
            byte[4] dashdotted = [4,6,4,2];
        }
        static this() {
            dashlist[0] = dashed;
            dashlist[1] = dotted;
            dashlist[2] = dashdotted;
        }

        void drawLine(int x1, int y1, int x2, int y2) {
            gdk_draw_line(drawable, peer, x1,y1,x2,y2);
        }

        void drawPolyline(Point[] pts) {
            gdk_draw_lines(drawable, peer, cast(GdkPoint*)pts.ptr, pts.length);
        }

        void drawPolygon(Point[] pts) {
            gdk_draw_polygon(drawable, peer, false, cast(GdkPoint*)pts.ptr, pts.length);
        }

        void fillPolygon(Point[] pts) {
            gdk_draw_polygon(drawable, peer, true, cast(GdkPoint*)pts.ptr, pts.length);
        }

        void drawText(int x, int y, char[] str) {
            pango_layout_set_text(layout,str.ptr,str.length);
            gdk_draw_layout(drawable,peer,x,y,layout);
        }

        void drawImage(Image im, int x, int y, PaintMode mode = PaintMode.Copy) {
            GdkGCValues vals;
            gdk_gc_get_values(peer,&vals);
            gdk_gc_set_function(peer,paintModeToNative(mode));
            gdk_draw_drawable(drawable,peer,im.peer,0,0,x,y,-1,-1);
            gdk_gc_set_function(peer,vals.Function);
        }

        void drawSubImage(Image im, int x, int y,
                    int sx, int sy, int sw, int sh,
                     PaintMode mode = PaintMode.Copy) {
            GdkGCValues vals;
            gdk_gc_get_values(peer,&vals);
            gdk_gc_set_function(peer,paintModeToNative(mode));
            gdk_draw_drawable(drawable,peer,im.peer,sx,sy,x,y,sw,sh);
            gdk_gc_set_function(peer,vals.Function);
        }

        void stretchImage(Image im, int x, int y, int w, int h,
                     PaintMode mode = PaintMode.Copy) {
            // TODO
            GdkGCValues vals;
            gdk_gc_get_values(peer,&vals);
            gdk_gc_set_function(peer,paintModeToNative(mode));
            gdk_draw_drawable(drawable,peer,im.peer,0,0,x,y,-1,-1);
            gdk_gc_set_function(peer,vals.Function);
        }

        void stretchSubImage(Image im, int x, int y, int w, int h,
             int sx, int sy, int sw, int sh,
                     PaintMode mode = PaintMode.Copy) {
            // TODO
            GdkGCValues vals;
            gdk_gc_get_values(peer,&vals);
            gdk_gc_set_function(peer,paintModeToNative(mode));
            gdk_draw_drawable(drawable,peer,im.peer,sx,sy,x,y,sw,sh);
            gdk_gc_set_function(peer,vals.Function);
        }

        void flush() { gdk_flush(); }

    }
}
