/* MinWin Peer module
 *
 * Mixin templates to simplify peer management
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.peer;

version (MinWin32) {
    private import minwin.mswindows;
    alias HWND PeerForAdd;
    alias PeerForAdd WindowChildPeer;
} else version (GTK) {
    private import minwin.gtk;
    alias GtkWidget* PeerForAdd;
    alias PeerForAdd WindowChildPeer;
}

// possible values for hasPeer property
enum {
    NO_PEER,            // object has no peer
    FOREIGN_PEER, // peer is not owned by object
    OWNS_PEER         // object owns peer
}

template PeerMixin() {
    ~this() {
        disposePeer();
    }
    int hasPeer;
}

template SimplePeerMixin() {
    ~this() {
        disposePeer();
    }
    int hasPeer;
    void dispose() { disposePeer(); }
    void disposePeer() {
        if (hasPeer == OWNS_PEER) {
            version (MinWin32) {
                int ok = DeleteObject(peer);
                sysAssert(ok != false, "Failed to dispose peer Font");
            } else version (GTK) {
                g_object_unref(cast(GObject*)peer);
            }
        }
        hasPeer = NO_PEER;
    }
}

