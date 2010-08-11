/* Sample MinWin application: idle processing
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.samples.idle;

import minwin.all;
import std.random;
import std.string;
import std.utf;

extern (C)
int MinWinMain(Application* app) {
    Window win = new Window("Idle processing");
    char[] text    = "Idle processing...";
    char[] cur = "";
    win.quitOnDestroy = true;
    win.paintDelegate ~= delegate void(Component source, GContext gc) {
        auto Font font = new Font("",14,FontWeight.Bold);
        Font oldfont = gc.setFont(font);
        gc.drawText(100,100,text);
        gc.setFont(oldfont);
    };
    win.keyDelegate ~= delegate void(Component source, KeyEvent* event) {
        if (event.id == KeyPressedEvent) {
            char[4] buf;
            cur = toUTF8(buf,event.keyCode).dup;
        }
    };
    app.idleTime = 1000; // every second
    app.idleDelegate ~= delegate void() {
        text = cur ~ " " ~ toString(rand());
        win.repaint();
    };
    win.visible = true;
    return app.enterEventLoop();
}
