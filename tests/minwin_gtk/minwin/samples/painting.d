/* Sample MinWin application: Graphics and painting
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.samples.painting;

import minwin.all;

extern (C)
int MinWinMain(Application* app) {
    Window win = new Window("Painting Sample");
    win.quitOnDestroy = true;

    Image im = win.getCompatibleImage(100,150);
    GContext gc = im.getGContext();

    auto Pen p2 = new Pen(RGB(0,0,0));
    Pen oldPen = gc.setPen(p2);
    Rect r = LTWH(0,0,100,150);
    auto Brush b2 = new Brush(RGB(255,255,255));
    Brush oldBrush = gc.setBrush(b2);
    gc.fillRect(r);
    gc.drawRect(r);
    gc.setBrush(oldBrush);

    PenData pd;
    pd.width = 4;
    pd.style = PenStyle.Solid;
    pd.color = RGB(100,0,120);
    auto Pen p = new Pen(&pd);
    gc.setPen(p);
    gc.drawLine(0,0,100,150);
    gc.drawLine(100,0,0,150);
    gc.drawLine(50,0,50,150);
    gc.setPen(oldPen);
    gc.dispose();

    win.paintDelegate ~= delegate void(Component source, GContext pc) {

        auto Font font = new Font("", 20, FontWeight.Bold);
        Font oldfont = pc.setFont(font);
        pc.drawText(100,100,"testing");
        pc.setFont(oldfont);

        pc.drawLine(10,10,20,20);
        pc.drawLine(30,10,35,50);

        static Point[3] pts = [{{40,10}}, {{45,50}}, {{50,30}}];
        pc.drawPolyline(pts);

        static Point[4] pts2 = [{{70,10}},{{75,50}},{{80,30}},{{90,10}}];
        pc.drawPolygon(pts2);

        static Point[4] pts3 = [{{100,10}},{{105,50}},{{110,30}},{{120,10}}];
        pc.fillPolygon(pts3);

        // try different line styles and colors
        PenData pd;
        pd.width = 4;
        pd.color = RGB(100,200,0);
        pd.style = PenStyle.Dash;
        auto Pen p1 = new Pen(&pd);
        Pen oldPen = pc.setPen(p1);
        pc.drawLine(10,100,20,200);

        pd.color = RGB(0,200,200);
        auto Pen p2 = new Pen(&pd);
        pc.setPen(p2);
        pc.drawLine(50,100,50,200);

        pc.setPen(oldPen);

        pc.drawImage(im,180,30);
    };

    win.visible = true;
    return app.enterEventLoop();
}
