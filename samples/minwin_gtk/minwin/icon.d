/* MinWin Icon class
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.icon;

private {
    import minwin.component;
    import minwin.image;
}

version (MinWin32) {
    private import minwin.mswindows;
    private import minwin.app;

    alias HICON IconPeer;
/*
    struct IconData {
        ICONINFO iconinfo;
        void bitmap(Bitmap bm) {
            iconinfo.hbmColor = bm.peer;
        }
        void mask(Bitmap mask) {
            iconinfo.hbmMask = bm.peer;
        }
    }
*/
    class Icon {
        IconPeer peer;

        this(char[] iconName) {
            if (useWfuncs)
                peer = LoadIconW(gApp.hInstance, toUTF16z(iconName));
            else
                peer = LoadIconA(gApp.hInstance, toMBSz(iconName));
            hasPeer = OWNS_PEER;
        }
/*
        this(IconData* info) {
            info.iconinfo.fIcon = true;
            peer = CreateIconIndirect(&info.iconinfo);
            hasPeer = OWNS_PEER;
        }
*/
/*
        this(Bitmap bitmap, Bitmap mask = null) {
            ICONINFO iinfo;
            iinfo.fIcon = true;
            iinfo.hbmColor = bitmap.peer;
            if (mask)
                iinfo.hbmMask = mask.peer;
            peer = CreateIconIndirect(&iinfo);
            hasPeer = OWNS_PEER;
        }
*/
        this(IconPeer p) {
            peer = p;
            hasPeer = FOREIGN_PEER;
        }

        ~this() {
            dispose();
        }
        void dispose() {
            disposePeer();
        }

        // Peer management
        int hasPeer;
        void disposePeer() {
            if (hasPeer == OWNS_PEER)
                DeleteObject(peer);
            hasPeer = NO_PEER;
        }
    }

} else version (GTK) {

    private import minwin.gtk;
    private import minwin.app;
    // peer is pixbuf
    class Icon{}

}
