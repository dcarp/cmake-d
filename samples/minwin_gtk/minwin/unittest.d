/* MinWin unittest
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

import minwin.all;

extern (C)
int MinWinMain(Application* app) {
    Point p = XY(100,100);
    Group g = new Group(null);
    app.rsrc("100");
    return 0;
}

