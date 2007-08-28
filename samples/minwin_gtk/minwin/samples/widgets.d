/* Sample MinWin application: widgets
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.samples.widgets;

import minwin.all;
import minwin.logging;
import std.utf;

extern (C)
int MinWinMain(Application* app) {
    Window win = new Window("Widgets");
    win.quitOnDestroy = true;
    win.backgroundColor = systemBackgroundColor();
    win.layoutMgr = new FlowLayout;

    CheckBox b3 = new CheckBox(win,"check 1");
    CheckBox b4 = new CheckBox(win,"check 2");
    ToggleButton b5 = new ToggleButton(win,"toggle 1");

    ToggleGroup g = new ToggleGroup;
    GroupBox box = new GroupBox(win,"Group");
    box.layoutMgr = new FlowLayout;
    RadioButton b1 = new RadioButton(box,"click me");
    RadioButton b2 = new RadioButton(box,"no, click me");
    g.addButton(b1);
    g.addButton(b2);
    g.select(0);

    Label lab = new Label(win,"This is a label");
    Text t1 = new Text(win,"single line");
    t1.userPreferredWidth = 60;
    MultiLineText t2 = new MultiLineText(win,"multi line text area");
    t2.userPreferredSize(60,60);

    char[][] strs;
    strs ~= "hello";
    strs ~= "world";
    strs ~= "bye";
    ComboBox combo = new ComboBox(win,strs);
    combo.selection = 0;

    ListBox list = new ListBox(win,strs);
    list.selection = 0;
    list.userPreferredHeight = 60;

    Canvas p = new Canvas(win);
    p.keyDelegate ~= delegate void(Component source, KeyEvent* event) {
        if (event.id == KeyPressedEvent) {
            char[4] buf;
            win.title = "you hit the " ~ toUTF8(buf,event.keyChar) ~ " key";
        }
    };
    p.paintDelegate ~= delegate void(Component source, GContext gc) {
        assert(source !is null);
        scope Brush b = new Brush(RGB(250,20,20));
        Brush oldBrush = gc.setBrush(b);
        Rect r = LTWH(0,0,source.width(),source.height());
        gc.fillRect(r);
        gc.setBrush(oldBrush);
    };
    p.userPreferredSize(20,20);

    ScrollBar sb = new ScrollBar(win,Horizontal);

    ScrollPane sp = new ScrollPane(win);
    MultiLineText t3 = new MultiLineText(sp,"This is a big text block that needs some scrolling maybe if we are lucky");
    t3.userPreferredSize(221,334); // make a large scrollable area
    sp.userPreferredSize(100,100);

    win.pack();
    win.visible = true;

    p.requestFocus(); // on GTK must be made visible first
    return app.enterEventLoop();
}
