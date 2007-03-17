/* Sample MinWin application to mimic winsamp.d
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */
module minwin.samples.sample;

import minwin.all;
import minwin.logging;
import std.string;
version (Windows) {
    import minwin.mswindows;
}

extern (C)
int MinWinMain(Application* app) {
    Window win = new Window("MinWin Sample");
    char[] text    = "D Does Windows, Motif and GTK";
    win.quitOnDestroy = true;
    win.paintDelegate ~= delegate void(Component source, GContext gc) {
        FontData fd;
        fd.size = 18;
        fd.weight = FontWeight.Bold;
        auto Font font = new Font(fd);
        Font oldfont = gc.setFont(font);
        gc.drawText(100,100,text);
        gc.setFont(oldfont);
        //        Image im = win.loadCompatibleImage(44);
        //        gc.drawImage(im,200,200);
    };

    win.mouseDelegate ~= delegate void(Component source, MouseEvent* event) {
        Point pt = event.point;
        text = pt.toString ~ " " ~ toString(cast(int)event.id) ~ " " ~ toString(event.modifiers);
        win.repaint();
    };

    Button b = new Button(win,"Click me");
    Button b2 = new Button(win,"Don't click me");

    // like winsamp.d place buttons by hand
    Point s = b.preferredSize;
    Rect r = LTWH(20,50,s.x,s.y);
    b.setBounds(r);
    s = b2.preferredSize;
    r.LTWH(100,50,s.x,s.y);
    b2.setBounds(r);

    // define actions to perform on button clicks
    b.actionDelegate ~= delegate void(Component source) {
        informationDialog(win, "Hello, world!", "Greeting");
    };
    b2.actionDelegate ~= delegate void(Component source) {
        warningDialog(win, "You've been warned...", "Prepare to GP fault");
        *(cast(int*) null) = 666;
    };

    // show window
    version (Windows) {
        ShowWindow(win.peer,gApp.nCmdShow);
    } else {
        win.visible = true;
    }

    return app.enterEventLoop();
}
