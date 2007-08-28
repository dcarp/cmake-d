/* Sample MinWin application: layout and groups
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.samples.layout;

import minwin.all;
import std.random;
import std.string;

extern (C)
int MinWinMain(Application* app) {

    Window win = new Window("Layout Sample");
    char[] text = "Click the Random number button";
    win.quitOnDestroy = true;

    // set table layout
    static double[3] yy = [.3, .2, .5];
    static double[2] xx = [.5,.5];
    win.layoutMgr = new TableLayout(xx,yy);

    // define some buttons to put in the table
    Button b1 = new Button(win,"Random number");
    Button b2 = new Button(win,"hide groups");
    Button b3 = new Button(win,"hide layout");

    // define a group to put in the table
    Group g = new Group(win);
    FlowLayout flow = new FlowLayout();
    flow.sideStretch = true;
    g.layoutMgr = flow;
    Button sub1 = new Button(g,"click random");
    Button sub2 = new Button(g,"sub2");

    // make a sub-group of g
    Group g2 = new Group(g);
    flow = new FlowLayout(Dir.Horizontal);
    flow.flowReverse = 1;
    g2.layoutMgr = flow;
    Button sub3 = new Button(g2,"sub3");
    Button sub4 = new Button(g2,"sub4");
    Button sub5 = new Button(g2,"sub5");

    Button b4 = new Button(win,"b3");

    // define actions
    b1.actionDelegate ~= delegate void(Component source) {
        sub1.text = toString(rand());
    };
    b2.actionDelegate ~= delegate void(Component source) {
        g.visible = !g.visible;
    };
    b3.actionDelegate ~= delegate void(Component source) {
        // remove from layout computations
        g.parentOwnsLayout = !g.parentOwnsLayout;
    };

    win.pack();
    win.visible = true;

    Window win2 = new Window("Border Layout Sample");
    win2.quitOnDestroy = true;
    BorderLayout bl = new BorderLayout();
    Button w2b1 = new Button(win2,"north");
    bl.location[Loc.North] = w2b1;
    Button w2b2 = new Button(win2,"south");
    bl.location[Loc.South] = w2b2;
    Button w2b3 = new Button(win2,"east");
    bl.location[Loc.East] = w2b3;
    Button w2b4 = new Button(win2,"west");
    bl.location[Loc.West] = w2b4;
    Button w2b5 = new Button(win2,"center");
    bl.location[Loc.Center] = w2b5;
    win2.layoutMgr = bl;

    win2.pack();
    win2.visible = true;

    return app.enterEventLoop();
}
