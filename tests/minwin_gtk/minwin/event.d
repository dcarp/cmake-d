/* MinWin Event classes
 *
 * Various event classes for key, mouse, focus events, etc
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.event;

private import minwin.geometry;

enum Modifier {
    Shift = 1,
    Alt = 2,
    Ctrl = 4,
    Command = 8,
    Meta = 16
}

version (MinWin32) {
    private import minwin.mswindows;

    alias MSG EventNative;

    template EventBaseImpl() {
        int modifiers() {
            int mod = 0;
            if ((GetKeyState(VK_LSHIFT) | GetKeyState(VK_RSHIFT)) & 0x8000)
                mod |= Modifier.Shift;
            if ((GetKeyState(VK_LCONTROL) | GetKeyState(VK_RCONTROL)) & 0x8000)
                mod |= Modifier.Ctrl;
            if ((GetKeyState(VK_LMENU) | GetKeyState(VK_RMENU)) & 0x8000)
                mod |= Modifier.Alt;
            return mod;
        }

        int id() { return native.message; }
    }

    struct Event {
        EventNative native;
        mixin EventBaseImpl!();
    }

    Event toEvent(EventNative nat) {
        Event res;
        res.native = nat;
        return res;
    }

    alias MSG KeyEventNative;
    struct KeyEvent {
        KeyEventNative native;
        // UTF-32 character typed
        dchar keyChar() { return cast(dchar)native.wParam; }
        // key code
        int keyCode() { return native.wParam; }
        int keyRepeat() { return native.lParam & 0x0F; }
        mixin EventBaseImpl!();
    }
    alias WM_CHAR        KeyPressedEvent;
    alias WM_KEYDOWN KeyDownEvent;
    alias WM_KEYUP     KeyUpEvent;


    alias WM_MOUSEMOVE        MouseMoveEvent;
    alias WM_LBUTTONDOWN    MouseDownEvent;
    alias WM_LBUTTONUP        MouseUpEvent;
    alias WM_RBUTTONDOWN    MouseAlt1DownEvent;
    alias WM_RBUTTONUP        MouseAlt1UpEvent;
    alias WM_MBUTTONDOWN    MouseAlt2DownEvent;
    alias WM_MBUTTONUP        MouseAlt2UpEvent;

    alias MSG MouseEventNative;
    struct MouseEvent {
        MouseEventNative native;
        Point point() {
            return XY(LOWORD(native.lParam),HIWORD(native.lParam));
        }
        mixin EventBaseImpl!();
    }

    //    alias WM_ACTIVATE    WindowActivateEvent;
    // also focus event, destory event
    alias WM_SIZE            WindowSizeEvent;
    alias WM_SIZING        WindowSizingEvent;
    alias WM_MOVE            WindowMoveEvent;
    alias WM_MOVING        WindowMovingEvent;

    alias MSG WindowEventNative;
    struct WindowEvent {
        WindowEventNative native;
        mixin EventBaseImpl!();
    }

    // TODO: add event filter api

    bool nextEvent(Event* event) {
        return GetMessageA(&event.native,cast(HWND)null,0,0) != 0;
    }

    bool peekEvent(Event* event) {
        return PeekMessageA(&event.native,cast(HWND)null,0,0,PM_REMOVE) != 0;
    }

    void dispatchEvent(Event* event) {
        TranslateMessage(&event.native);
        DispatchMessageA(&event.native);
    }

    //    alias void* KeyEventPeer;
    //    alias void* MouseEventPeer;
    //    alias void* MotionEventPeer;
} else version (GTK) {

    private import minwin.gtk;

    alias GdkEvent EventNative;

    template EventBaseImpl() {
        int modifiers() {
            int mod;
            int state;
            if (native.type == GdkEventType.GDK_KEY_PRESS || native.type == GdkEventType.GDK_KEY_RELEASE) {
                GdkEventKey* ke = cast(GdkEventKey*)(&native);
                state = ke.state;
            } else {
                //            return event.message;
            }
            return mod;
        }

        GdkEventType id() { return native.type; }
    }

    struct Event {
        EventNative native;
        mixin EventBaseImpl!();
    }

    Event toEvent(EventNative nat) {
        Event res;
        res.native = nat;
        return res;
    }

    alias GdkEventType.GDK_KEY_PRESS KeyPressedEvent;
    alias GdkEventType.GDK_KEY_PRESS KeyDownEvent;
    alias GdkEventType.GDK_KEY_RELEASE KeyUpEvent;

    alias GdkEventKey KeyEventNative;
    struct KeyEvent {
        KeyEventNative native;
        // UTF-32 character typed
        dchar keyChar() { return cast(dchar)native.keyval; }

        // key code
        int keyCode() { return native.keyval; }

        int keyRepeat() { return 0; }
        mixin EventBaseImpl!();
    }


    alias GdkEventType.GDK_MOTION_NOTIFY        MouseMoveEvent;
    alias GdkEventType.GDK_BUTTON_PRESS    MouseDownEvent;
    alias GdkEventType.GDK_BUTTON_RELEASE    MouseUpEvent;
    alias GdkEventType.GDK_2BUTTON_PRESS    MouseAlt1DownEvent;
    alias GdkEventType.GDK_BUTTON_RELEASE    MouseAlt1UpEvent;
    alias GdkEventType.GDK_3BUTTON_PRESS    MouseAlt2DownEvent;
    alias GdkEventType.GDK_BUTTON_RELEASE    MouseAlt2UpEvent;

    alias GdkEventButton MouseEventNative;
    alias GdkEventButton MotionEventNative;
    struct MouseEvent {
        MouseEventNative native;
        Point point() {
            return XY(cast(int)native.x,cast(int)native.y);
        }
        mixin EventBaseImpl!();
    }

    //    alias WM_ACTIVATE    WindowActivateEvent;
    alias GdkEventType.GDK_CONFIGURE WindowSizeEvent;
    alias GdkEventType.GDK_CONFIGURE WindowSizingEvent;
    alias GdkEventType.GDK_CONFIGURE WindowMoveEvent;
    alias GdkEventType.GDK_CONFIGURE WindowMovingEvent;

    alias GdkEventConfigure WindowEventNative;
    struct WindowEvent {
        WindowEventNative native;
        mixin EventBaseImpl!();
    }

    // TODO: add event filter api

    bool nextEvent(Event* event) {
        assert(false);
        while (gtk_events_pending() == 0) {} // busy wait - icky
        peekEvent(event);
        return true;    // how does one check if a Quit is pending?
    }

    bool peekEvent(Event* event) {
        Event* e = cast(Event*)gdk_event_get();
        if (e) {
            *event = *e;
            gdk_event_free(cast(GdkEvent*)e);
        }
        return e !is null;
    }

    void dispatchEvent(Event* event) {
        gtk_main_do_event(&event.native);
    }

}
