/* MinWin Scroll classes
 *
 * ScrollBar and ScrollPane
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.scroll;

public import minwin.component;

private {
    import minwin.app;
    import minwin.window;
    import minwin.peerimpl;
    import std.string;
    import minwin.logging;
}

version (GTK) version = SharedScrollData;
version (SharedScrollData) {
    struct ScrollData {
        int min;
        int max;
        int increment;
        int value;
    }
}
enum ScrollMask {
    Range = 1, Increment = 2, Value = 4
}
const int Horizontal = 1;
const int Vertical = 2;

version (MinWin32) {

    private import minwin.mswindows;

    alias SCROLLINFO ScrollData;

    class ScrollBar : WindowChild {
        int orientation;
        this(Component parent, int orientation, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            uint style = orientation==Horizontal?SBS_HORZ:SBS_VERT;
            peer = CreateWindowA("SCROLLBAR","",
                 style | WS_CHILD | WS_VISIBLE,
                 0,0,10,10,parentp,
                 cast(HMENU)0,gApp.hInstance,null);
            sysAssert(peer !is null, "Failed to create peer scrollbar");
            this.name = name;
            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);
        }
        Point preferredSize() {
            int width,height;
            if (orientation == Vertical) {
                height = 50;
                width = 16;
            } else {
                height = 16;
                width = 50;
            }
            if (userPreferredWidth > 0)
                width = userPreferredWidth;
            if (userPreferredHeight > 0)
                height = userPreferredHeight;
            return XY(width,height);
        }
        mixin WindowChildImpl!();

        private uint windowsMask(uint mask) {
            uint res = 0;
            if (mask & ScrollMask.Range)
                res |= SIF_RANGE;
            if (mask & ScrollMask.Value)
                res |= SIF_POS;
            if (mask & ScrollMask.Increment)
                res |= SIF_PAGE;
            return res;
        }

        void setData(inout ScrollData state, uint mask) {
            state.cbSize = SCROLLINFO.sizeof;
            state.fMask = windowsMask(mask);
            SetScrollInfo(peer,SB_CTL,&state, false);
        }
        void getData(inout ScrollData state, uint mask) {
            state.cbSize = SCROLLINFO.sizeof;
            state.fMask = windowsMask(mask);
            GetScrollInfo(peer,SB_CTL,&state);
        }
        int value() {
            ScrollData state;
            getData(state,ScrollMask.Value);
            return state.nPos;
        }
    }

    class ScrollPane : WindowChild {
        Point origin;

        // how to customize page size and steps and limits? need API to each scrollbar

        int hstep = 1; // given bounds of child this is how quickly to move through it
        int vstep = 1;

        this(Component parent, int orientations = Horizontal | Vertical, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            int style;
            if (orientations & Horizontal) style |= WS_HSCROLL;
            if (orientations & Vertical) style |= WS_VSCROLL;
            peer = CreateWindowA("MinWinScrollWindow","",
                 style | WS_CHILD | WS_VISIBLE,
                 0,0,50,50,parentp,
                 cast(HMENU)0,gApp.hInstance,null);
            this.name = name;
            clearBackgroundOnPaint = false;
            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);
        }
        mixin WindowChildImpl!();

        void layout(bool validateParent) {
            if (parent && validateParent)
                parent.layout(true);
            if (childLayoutDirty && child) {
                Point s = child.preferredSize;
                Rect r = LTWH(origin.x,origin.y,s.x,s.y);
                child.setBounds(r);
                childLayoutDirty = false;
            }
            foreach( Component ch; this) {
                ch.layout(false);
            }
        }

        int WindowProc(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam) {
            version (LOG) log.printf(" in ScrollPane windowproc msg %d\n",uMsg);
            bool doDefault = true;
            if (uMsg == WM_HSCROLL) {
                SCROLLINFO data;
                data.cbSize = SCROLLINFO.sizeof;
                data.fMask = SIF_ALL;
                GetScrollInfo(hWnd, SB_HORZ, &data);
                int cmd = LOWORD(wParam);
                int oldPos = data.nPos;
                if (cmd == SB_LINELEFT) data.nPos--;
                if (cmd == SB_LINERIGHT) data.nPos++;
                if (cmd == SB_PAGELEFT) data.nPos -= data.nPage;
                if (cmd == SB_PAGERIGHT) data.nPos += data.nPage;
                data.fMask = SIF_POS;
                SetScrollInfo(hWnd, SB_HORZ, &data, true);
                GetScrollInfo(hWnd, SB_HORZ, &data);
                if (data.nPos != oldPos) {
                    int step = hstep*(oldPos-data.nPos);
                    ScrollWindowEx(hWnd,step,0,null,null,null,null,SW_INVALIDATE | SW_ERASE);
                    //      ScrollWindow(hWnd,step,0,null,null);
                    if (child) {
                        WindowChild wc = cast(WindowChild)child;
                        MoveWindow(wc.getPeer,step,0,0,0,false);
                        UpdateWindow(wc.getPeer);
                    }
                    origin.XY(origin.x + step, origin.y);
                }
                doDefault = false;
            } else if (uMsg == WM_VSCROLL) {
                SCROLLINFO data;
                data.cbSize = SCROLLINFO.sizeof;
                data.fMask = SIF_ALL;
                GetScrollInfo(hWnd, SB_VERT, &data);
                int cmd = LOWORD(wParam);
                int oldPos = data.nPos;
                if (cmd == SB_LINEUP) data.nPos--;
                if (cmd == SB_LINEDOWN) data.nPos++;
                if (cmd == SB_PAGEUP) data.nPos -= data.nPage;
                if (cmd == SB_PAGEDOWN) data.nPos += data.nPage;
                data.fMask = SIF_POS;
                SetScrollInfo(hWnd, SB_VERT, &data, true);
                GetScrollInfo(hWnd, SB_VERT, &data);
                if (data.nPos != oldPos) {
                    int step = vstep*(oldPos-data.nPos);
                    ScrollWindowEx(hWnd,0,step,null,null,null,null,SW_INVALIDATE | SW_ERASE);
                    //      ScrollWindow(hWnd,0,step,null,null);
                    if (child) {
                        WindowChild wc = cast(WindowChild)child;
                        MoveWindow(wc.getPeer,0,step,0,0,false);
                        UpdateWindow(wc.getPeer);
                    }
                    origin.XY(origin.x, origin.y + step);
                }
                doDefault = false;
            }
            return doDefault;
        }
    }

    extern(Windows) int MinWinScrollWindowProc(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam) {
        version(LOG) log.printf("in minwin scroll window proc hwnd %p %d %d %d\n",hWnd,uMsg,wParam,lParam);
        bool doDefault = true;
        ScrollPane pane = cast(ScrollPane)peerToWindowChild(hWnd);
        version(LOG) log.printf("in minwin scroll window proc win %p\n",pane);
        if (pane !is null)
            doDefault = pane.WindowProc(hWnd,uMsg,wParam,lParam) != 0;
        if (doDefault)
            return DefWindowProcA(hWnd, uMsg, wParam, lParam);
        else
            return 0;
    }
    static this() {
        HINSTANCE hInst = GetModuleHandleA(null);
        WNDCLASSA wc;
        wc.lpszClassName = "MinWinScrollWindow";
        wc.style = CS_CLASSDC | CS_HREDRAW | CS_VREDRAW;
        wc.lpfnWndProc = &MinWinScrollWindowProc;
        wc.hInstance = hInst;
        wc.hIcon = LoadIconA(cast(HINSTANCE) null, IDI_APPLICATION);
//        wc.hIconSm = DefaultWindowSmallIcon.peer;
        wc.hCursor = LoadCursorA(cast(HINSTANCE) null, IDC_ARROW);
        wc.hbrBackground = cast(HBRUSH) (COLOR_WINDOW + 1); // not +1 for default
        wc.lpszMenuName = null;
        wc.cbClsExtra = 0;
        wc.cbWndExtra = 0;
        RegisterClassA(&wc);
    }

} else version (GTK) {

    private import minwin.gtk;
    private import minwin.gtk_peers;

    class ScrollBar : WindowChild {
        this(Component parent, int orientation, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            if (orientation == Horizontal)
                peer = gtk_hscrollbar_new(null);
            else
                peer = gtk_vscrollbar_new(null);
            gtk_container_add(cast(GtkContainer*)parentp,peer);
            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);
            gtk_widget_realize(peer);
            visible = true;
        }

        mixin WindowChildImpl!();

    }

    class ScrollPane : WindowChild {
        MinWinGtkPeer* content;
        this(Component parent, int orientations = Horizontal | Vertical, char[] name = "") {
            PeerForAdd parentp = parent.getPeerForAdd();
            this.name = name;
            peer = gtk_scrolled_window_new(null,null);
            gtk_container_add(cast(GtkContainer*)parentp,peer);
            GtkWidget* view = gtk_viewport_new(null,null);
            gtk_container_add(cast(GtkContainer*)peer,view);

            // add our peer to hook into GTK size allocation algorithm
            GtkWidget* wcontent = MinWinGtkPeer_new();
            content = cast(MinWinGtkPeer*)wcontent;
            gtk_widget_set_sensitive(wcontent,true);
            content.sizeRequest = &gtkRequest;
            content.sizeAllocate = &gtkAllocate;
            gtk_container_add(cast(GtkContainer*)view,wcontent);

            setWindowChildPeer(this,peer,OWNS_PEER);
            parent.addChild(this);

            // are all of these really needed?
            gtk_widget_realize(wcontent);
            gtk_widget_show(wcontent);
            gtk_widget_realize(view);
            gtk_widget_show(view);
            gtk_widget_realize(peer);
            visible = true;
        }

        mixin WindowChildImpl!();

        void layout(bool validateParent) {
            if (parent && validateParent)
                parent.layout(true);
            childLayoutDirty = false;
        }

        PeerForAdd getPeerForAdd() {
            return cast(GtkWidget*)content;
        }

        // callback from the GTK peer asking for preferred size
        private void gtkRequest(GtkWidget *w, GtkRequisition* req) {
            version(LOG)log.writefln("gtkRequest for scrollpane");
            Component ch = child;
            if (ch is null) return;
            Point s = ch.preferredSize;
            req.width = s.x;
            req.height = s.y;
            version(LOG)log.writefln("done gtkRequest for scrollpane");
        }

        // callback from GTK peer telling us our position
        private void gtkAllocate(GtkWidget *w, GtkAllocation* req) {
            version(LOG)log.writefln("gtkAllocate for scrollpane");
            Component ch = child;
            if (ch is null) return;
            Rect r = toRect(*req);
            ch.size = XY(r.width,r.height);
            ch.layout(false);
            childLayoutDirty = false;
            version(LOG)log.writefln("done gtkAllocate for scrollpane");
        }

    }
}
