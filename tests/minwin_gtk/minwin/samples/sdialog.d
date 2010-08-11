/* Sample dialog application with OOP style
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */
module minwin.samples.sdialog;

import minwin.all;
import minwin.logging;

class MyDialog : Dialog {
    int result;
    this(MyWindow win, char[] str) {
        super(win,str);
        layoutMgr = new FlowLayout;
        Button clicked;
        Button ok = new Button(this,"OK");
        Button cancel = new Button(this,"Cancel");
        CheckBox bb = new CheckBox(this,"this is a big check");
        CheckBox bb2 = new CheckBox(this,"this check");
        ok.actionDelegate ~= &okCallback;
        cancel.actionDelegate ~= &cancelCallback;
        pack();
    }
    void okCallback(Component c) {
        MyWindow win = cast(MyWindow)owner;
        win.title = "you hit ok";
        result = 100;
        visible = false;
    }
    void cancelCallback(Component c) {
        MyWindow win = cast(MyWindow)owner;
        win.title = "you hit cancel";
        result = 101;
        visible = false;
    }
}

class MyWindow : Window {
    this(char[] str) {
        super(str);
        layoutMgr = new FlowLayout;
        Button but = new Button(this,"click me");
        but.actionDelegate ~= &doDialogCallback;
    }
    void doDialogCallback(Component c){doDialog();}
    void doDialog() {
        MyDialog dlg = new MyDialog(this,"hello");
        dlg.visible = true;
        if (dlg.result == 0) {
            title = "you destroyed the dialog";
        }
    }
}

extern (C)
int MinWinMain(Application* app) {
    MyWindow win = new MyWindow("window");
    win.quitOnDestroy = true;
    win.visible = true;
    return app.enterEventLoop();
}
