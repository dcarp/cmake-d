/* MinWin Image class
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.image;

public import minwin.component;

private {
    import minwin.app;
    import minwin.paint;
}

version (MinWin32) {
    private import minwin.mswindows;

    alias HBITMAP ImagePeer;

    class Image {
        int width,height;
        ImagePeer peer;

        this(ImagePeer bm) {
            peer = bm;
            hasPeer = FOREIGN_PEER;
        }

        void getBits() {
            // call GetDIBits. make sure bitmap isn't selected in memGC
            getGContext();
            //            GetDIBits(memGC.peer,sdf);
        }

        GContext getGContext() {
            GContext gc = newGContext();
            gc.peer = CreateCompatibleDC(null); // hmm. null is for screen
            sysAssert(gc.peer !is null, "Failed to create compatible DC for image");
            gc.hasPeer = OWNS_PEER;
            SelectObject(gc.peer,peer);
            return gc;
        }

        mixin SimplePeerMixin!();

    }
} else version (GTK) {

    private import minwin.window;
    private import minwin.gtk;

    //    alias GdkPixbuf* ImagePeer;
    alias GdkPixmap* ImagePeer;

    class Image {
        int width,height;
        ImagePeer peer;

        this(ImagePeer bm) {
            peer = bm;
            hasPeer = FOREIGN_PEER;
        }

        GContext getGContext() {
            GContext gc = newGContext();
            gc.drawable = peer;
            gc.peer = gdk_gc_new(gc.drawable);
            gc.hasPeer = OWNS_PEER;
            return gc;
        }

        mixin SimplePeerMixin!();
    }
}
