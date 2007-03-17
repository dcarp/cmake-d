/* MinWin Font class
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.font;

private {
    import minwin.app;
    import minwin.component;
    import minwin.peerimpl;
    import std.string;
    import std.c.string;
}

enum FontWeight {
    Any = 0,
    Thin = 100,
    ExtraLight = 200,
    Light = 300,
    Normal = 400,
    Medium = 500,
    SemiBold = 600,
    Bold = 700,
    ExtraBold = 800,
    Heavy = 900
}

enum StandardFont {
    Gui, Fixed, Variable
}

version (GTK)    version = GenericFontDataStruct;
version (GenericFontDataStruct) {
    struct FontData {
        int size;
        FontWeight weight;
        bool italic;
        char[] name;
    }
}

version (MinWin32) {
    private import minwin.mswindows;

    alias HFONT FontPeer;

    alias LOGFONTA FontDataNative;
    struct FontData {
        FontDataNative native;
        void size(int size) { native.lfHeight = size; }
        int size() { return native.lfHeight; }
        void weight(FontWeight w) { native.lfWeight = w; }
        FontWeight weight() { return cast(FontWeight)native.lfWeight; }
        void italic(bool i) { native.lfItalic = i; }
        bool italic() { return native.lfItalic != 0; }
        char[] name() {
            char* s = native.lfFaceName.ptr;
            return s[0..strlen(s)];
        }
        void name(char[] n) {
            native.lfFaceName[0 .. n.length] = n[];
        }
    }


    alias TEXTMETRICA FontMetricsNative;
    struct FontMetrics {
        FontMetricsNative native;
        int size() { return native.tmHeight; }
        int ascent() { return native.tmAscent; }
        int descent() { return native.tmDescent; }
        int leading() { return native.tmExternalLeading; }
        int maxWidth() { return native.tmMaxCharWidth; }
    }

    class Font {
        FontPeer peer;

        this(inout FontData d) {
            d.native.lfCharSet = DEFAULT_CHARSET;
            peer = CreateFontIndirectA(&d.native);
            sysAssert(peer !is null, "Failed to create peer Font");
            hasPeer = OWNS_PEER;
        }

        //        mixin CommonFontCtor!();
        this(FontPeer p) {
            peer = p;
            hasPeer = FOREIGN_PEER;
        }

        this(char[] name, int size = 0, FontWeight weight = FontWeight.Normal) {
            FontData fd;
            if (size > 0)
                fd.size = size;
            if (weight > 0)
                fd.weight = weight;
            if (name.length > 0)
                fd.name = name;
            this(fd);
        }

        mixin SimplePeerMixin!();

    }

    Font standardFont(StandardFont id) {
        static Font[5] fonts;
        if (fonts[0] is null && id == StandardFont.Gui) {
            fonts[0] = new Font(GetStockObject(DEFAULT_GUI_FONT));
        } else if (fonts[1] is null && id == StandardFont.Fixed) {
            fonts[1] = new Font(GetStockObject(ANSI_FIXED_FONT));
        } else if (fonts[2] is null && id == StandardFont.Variable) {
            fonts[2] = new Font(GetStockObject(ANSI_VAR_FONT));
        }
        return fonts[id];
    }

} else version (GTK) {

    private import minwin.app;
    private import minwin.gtk;
    private import std.string;

    alias PangoFontDescription* FontPeer;

    struct FontMetrics {
        int size;
        int ascent;
        int descent;
        int leading;
        int maxWidth;
    }

    class Font {
        FontPeer peer;

        this(inout FontData d) {
            peer = pango_font_description_new();
            if (d.name.length > 0)
                pango_font_description_set_family(peer,toStringz(d.name));
            if (d.size > 0)
                pango_font_description_set_size(peer,d.size*PANGO_SCALE);
            if (d.weight > 0)
                pango_font_description_set_weight(peer,cast(PangoWeight)d.weight);
            hasPeer = OWNS_PEER;
        }

        //        mixin CommonFontCtor!();
        this(FontPeer p) {
            peer = p;
            hasPeer = FOREIGN_PEER;
        }

        this(char[] name, int size = 0, FontWeight weight = FontWeight.Normal) {
            FontData fd;
            if (size > 0)
                fd.size = size;
            if (weight > 0)
                fd.weight = weight;
            if (name.length > 0)
                fd.name = name;
            this(fd);
        }

        mixin PeerMixin!();
        void dispose() { disposePeer(); }
        void disposePeer() {
            if (hasPeer == OWNS_PEER)
                pango_font_description_free(peer);
            hasPeer = NO_PEER;
        }
    }

    // TODO: what are the standard GTK fonts??
    Font standardFont(StandardFont id) {
        static Font[5] fonts;
        FontData d;
        if (fonts[0] is null && id == StandardFont.Gui) {
            fonts[0] = new Font("variable");
        } else if (fonts[1] is null && id == StandardFont.Fixed) {
            fonts[1] = new Font("fixed");
        } else if (fonts[2] is null && id == StandardFont.Variable) {
            fonts[2] = new Font("variable");
        }
        return fonts[id];
    }

}
