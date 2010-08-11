/* Sample dialog application with procedural style
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.samples.sdialog2;

import minwin.all;

const int OK = 100;
const int CANCEL = 101;
const char[] KEY = "result";

extern (C)
int MinWinMain(Application* app) {
    Window win = new Window("window");
    win.quitOnDestroy = true;
    win.layoutMgr = new FlowLayout;
    Button but = new Button(win,"click me");
    but.actionDelegate ~= delegate void (Component c) {
        Window w = cast(Window)c.parent;
        Dialog dlg = new Dialog(w,"hit ok or cancel");
        dlg.layoutMgr = new FlowLayout;
        Button ok = new Button(dlg,"OK");
        ok.cmd = OK;
        Button cancel = new Button(dlg,"Cancel");
        cancel.cmd = CANCEL;
        dlg.commandDelegate ~= delegate void(Component c, int cmd) {
            Dialog dlg = cast(Dialog)c;
            switch (cmd) {
                case OK:
                    dlg.owner.title = "you hit ok";
                    break;
                case CANCEL:
                    dlg.owner.title = "you hit cancel";
                    break;
                default: assert(0);
            }
            // indicate a button was clicked
            int* data = new int;
            *data = cmd;
            dlg.userdata[KEY] = data;
            // end the dialog modality
            dlg.visible = false;
        };
        dlg.pack();
        dlg.visible = true;
        if ((KEY in dlg.userdata) is null) {
            w.title = "you destroyed the dialog";
        }
    };
    win.visible = true;
    return app.enterEventLoop();
}
