/* MinWin Sample: Groups of top-level windows
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.samples.topgroup;

import minwin.all;

extern (C)
int MinWinMain(Application* app) {

    Window win = new Window("Close window 2");
    win.cancelCloseDelegate ~= delegate bool(Component c) {
        // we could pop up a confirm dialog but let's just say
        // you can't destroy this window
        return true;
    };

    Window win2 = new Window("Testing 2");
    win2.quitOnDestroy = true;

    Group g = new Group(null);
    g ~= win;
    g ~= win2;

    static double[2] x = [.5,.5];
    static double[1] y = [1];
    g.layoutMgr = new TableLayout(x,y);

    Rect r;
    r.LTWH(100,100,600,300);
    g.setBounds(r);
    g.layout(false);

    g.visible = true;

    return app.enterEventLoop();
}
