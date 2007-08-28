/* Sample MinWin application: Menus
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.samples.menus;

import minwin.all;
import std.string;

extern (C)
int MinWinMain(Application* app) {
    Window win = new Window("Menu Sample");
    win.quitOnDestroy = true;
    win.layoutMgr = new FlowLayout;
    MenuBar mb = new MenuBar(win);
    Menu file = new Menu(mb,"File");
    file.add("Open...",100);
    file.addSeparator();
    file.add("Save...",234);
    Menu edit = new Menu(mb,"Edit");
    edit.add("Hello",400);
    edit.add("World",500);
    char[] text = "select menu";
    win.commandDelegate ~= delegate void(Component source, int cmd) {
        text = toString(cmd);
        win.repaint();
        if (cmd == 100) {
            // show open file dialog
            FileDialogData data;
            data.title = "Open File";
            if (openFileDialog(win,data)) {
                text = "you selected " ~ data.result;
            }
        } else if (cmd == 234) {
            // show save file dialog
            FileFilter[2] filt;
            filt[0].description = "Foo bar files";
            filt[0].extensions ~= "*.foo";
            filt[1].description = "All files";
            filt[1].extensions ~= "*";
            FileDialogData data;
            data.title = "Save File";
            data.filter = filt;
            if (saveFileDialog(win,data)) {
                text = "you saved " ~ data.result;
            }
        }
    };
    win.paintDelegate ~= delegate void(Component source, GContext gc) {
        auto Font font = new Font("",12);
        Font oldfont = gc.setFont(font);
        gc.drawText(100,100,text);
        gc.setFont(oldfont);
    };

    win.visible = true;
    return app.enterEventLoop();
}
