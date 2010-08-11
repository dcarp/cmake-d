/*
 * Windows API not covered by std.c.windows.windows
 */

module minwin.mswindows;

public import std.c.windows.windows;
package import std.windows.charset;
package import std.utf;

extern (Windows):
export BOOL PostMessageA(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);
export BOOL SendMessageA(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);
export BOOL SendMessageW(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);
export UINT SetTimer(HWND hWnd, uint id,uint time, TIMERPROC proc);
export BOOL KillTimer(HWND hWnd, uint id);
export BOOL IsWindowVisible (HWND hWnd);
export BOOL IsWindowEnabled (HWND hWnd);
export BOOL IsWindow (HWND hWnd);
export BOOL EnableWindow (HWND hWnd, BOOL enable);
export BOOL BringWindowToTop (HWND hWnd);
export BOOL DestroyWindow (HWND hWnd);
export BOOL MoveWindow (HWND hWnd, int x, int y, int w, int h, byte bRepaint);
export int SetWindowLongA (HWND hWnd, int nIndex, int dwNewLong);
export int GetWindowLongA (HWND hWnd, int nIndex);
export int GetWindowTextA (HWND hWnd, LPTSTR str, int count);
export int GetWindowTextW (HWND hWnd, LPWSTR str, int count);
export BOOL SetWindowTextA (HWND hWnd, LPTSTR str);
export BOOL SetWindowTextW (HWND hWnd, LPWSTR str);
export ushort GetKeyState(int key);
export ATOM RegisterClassExA(WNDCLASSEXA *lpWndClass);
export BOOL GetTextExtentPoint32A(HDC dc, LPCSTR str, int len, SIZE* s);
export BOOL GetTextExtentPoint32W(HDC dc, LPWSTR str, int len, SIZE* s);
export BOOL IsDialogMessageA(HWND hWnd, PMSG msg);
export int LoadStringA(HINSTANCE inst, LPSTR id, LPTSTR buf, int siz);
export int LoadStringW(HINSTANCE inst, LPWSTR id, LPWSTR buf, int siz);
export int MessageBoxW(HWND hWnd, LPCWSTR lpText, LPCWSTR lpCaption, UINT uType);
export int GetSystemMetrics(int nIndex);

/*
struct INITCOMMONCONTROLSEX {
    DWORD dwSize;
    DWORD dwICC;
}
export void InitCommonControls();
export BOOL InitCommonControlsEx(INITCOMMONCONTROLSEX*);
*/
export DWORD GetSysColor(int);

const uint WM_PAINTICON =                   0x0026;
const uint WM_ICONERASEBKGND =              0x0027;
const uint WM_NEXTDLGCTL =                  0x0028;
const uint WM_SPOOLERSTATUS =               0x002A;
const uint WM_DRAWITEM =                    0x002B;
const uint WM_MEASUREITEM =                 0x002C;
const uint WM_DELETEITEM =                  0x002D;
const uint WM_VKEYTOITEM =                  0x002E;
const uint WM_CHARTOITEM =                  0x002F;
const uint WM_SETFONT =                     0x0030;
const uint WM_GETFONT =                     0x0031;
const uint WM_SETHOTKEY =                   0x0032;
const uint WM_GETHOTKEY =                   0x0033;
const uint WM_QUERYDRAGICON =               0x0037;
const uint WM_COMPAREITEM =                 0x0039;

const uint WM_SIZING=                       0x0214;
const uint WM_CAPTURECHANGED=               0x0215;
const uint WM_MOVING=                       0x0216;
const uint WM_POWERBROADCAST=               0x0218;
const uint WM_DEVICECHANGE=                 0x0219;

const uint DS_MODALFRAME = 0x80;
const uint ICON_SMALL =         0;
const uint ICON_BIG =           1;

export BOOL GdiFlush();

struct SIZE {
  int cx;
  int cy;
}
alias SIZE* PSIZE;

const uint SBM_SETPOS                  =0x00E0;
const uint SBM_GETPOS                  =0x00E1;
const uint SBM_SETRANGE                =0x00E2;
const uint SBM_SETRANGEREDRAW          =0x00E6;
const uint SBM_GETRANGE                =0x00E3;
const uint SBM_ENABLE_ARROWS           =0x00E4;
const uint SBM_SETSCROLLINFO           =0x00E9;
const uint SBM_GETSCROLLINFO           =0x00EA;
const uint SIF_RANGE           =0x0001;
const uint SIF_PAGE            =0x0002;
const uint SIF_POS             =0x0004;
const uint SIF_DISABLENOSCROLL =0x0008;
const uint SIF_TRACKPOS        =0x0010;
const uint SIF_ALL             =(SIF_RANGE | SIF_PAGE | SIF_POS | SIF_TRACKPOS);
const uint SW_SCROLLCHILDREN   =0x0001;
const uint SW_INVALIDATE       =0x0002;
const uint SW_ERASE            =0x0004;

struct SCROLLINFO {
    UINT    cbSize;
    UINT    fMask;
    int     nMin;
    int     nMax;
    UINT    nPage;
    int     nPos;
    int     nTrackPos;
}
export int SetScrollInfo(HWND, int, SCROLLINFO*, BOOL);
export BOOL GetScrollInfo(HWND, int, SCROLLINFO*);


struct ICONINFO {
    BOOL    fIcon;
    DWORD   xHotspot;
    DWORD   yHotspot;
    HBITMAP hbmMask;
    HBITMAP hbmColor;
}
alias ICONINFO* PICONINFO;
export HICON CreateIconIndirect(PICONINFO piconinfo);
export HBITMAP CreateCompatibleBitmap(HDC hdc,int width,int height);
export COLORREF GetPixel(HDC hdc,int x,int y);
export HBRUSH CreateSolidBrush(COLORREF c);
export BOOL BitBlt(HDC dest,int x,int y,int width,int height,
           HDC src,int xsrc,int ysrc, DWORD op);
//alias HANDLE HBRUSH;
export HANDLE LoadImageA(HINSTANCE hInstance, LPCSTR lpName,UINT utype,
          int cx, int cy, UINT load);
export HANDLE LoadImageW(HINSTANCE hInstance, LPCWSTR lpName,UINT utype,
          int cx, int cy, UINT load);
enum { IMAGE_BITMAP, IMAGE_CURSOR, IMAGE_ICON };

const uint GW_HWNDFIRST =        0;
const uint GW_HWNDLAST =         1;
const uint GW_HWNDNEXT =         2;
const uint GW_HWNDPREV =         3;
const uint GW_OWNER =            4;
const uint GW_CHILD =            5;
const uint GW_MAX =              5;

const int GWL_USERDATA = -21;

export HWND GetWindow (HWND hWnd, int dir);

const uint MF_INSERT           =0x00000000L;
const uint MF_CHANGE           =0x00000080L;
const uint MF_APPEND           =0x00000100L;
const uint MF_DELETE           =0x00000200L;
const uint MF_REMOVE           =0x00001000L;
const uint MF_BYCOMMAND        =0x00000000L;
const uint MF_BYPOSITION       =0x00000400L;
const uint MF_SEPARATOR        =0x00000800L;
const uint MF_ENABLED          =0x00000000L;
const uint MF_GRAYED           =0x00000001L;
const uint MF_DISABLED         =0x00000002L;
const uint MF_UNCHECKED        =0x00000000L;
const uint MF_CHECKED          =0x00000008L;
const uint MF_USECHECKBITMAPS  =0x00000200L;
const uint MF_STRING           =0x00000000L;
const uint MF_BITMAP           =0x00000004L;
const uint MF_OWNERDRAW        =0x00000100L;
const uint MF_POPUP            =0x00000010L;
const uint MF_MENUBARBREAK     =0x00000020L;
const uint MF_MENUBREAK        =0x00000040L;
const uint MF_UNHILITE         =0x00000000L;
const uint MF_HILITE           =0x00000080L;
const uint MF_SYSMENU          =0x00002000L;
const uint MF_HELP             =0x00004000L;
const uint MF_MOUSESELECT      =0x00008000L;

export HMENU CreateMenu();
export BOOL DrawMenuBar(HWND win);
export BOOL SetMenu(HWND win, HMENU menu);
export BOOL AppendMenuA(HMENU menu, uint flags, void*item, char* str);
export BOOL AppendMenuW(HMENU menu, uint flags, void*item, wchar* str);

// 32 bit version
void* SetWindowLongPtr (HWND hWnd, int nIndex, void* dwNewLong) {
  return cast(void*)SetWindowLongA(hWnd,nIndex,cast(int)dwNewLong);
}
void* GetWindowLongPtr (HWND hWnd, int nIndex) {
  return cast(void*)GetWindowLongA(hWnd,nIndex);
}

/* CombineRgn() Styles */
enum {
  RGN_AND =            1,
  RGN_OR =             2,
  RGN_XOR =            3,
  RGN_DIFF =           4,
  RGN_COPY =           5
}

export BOOL EqualRgn(HRGN a, HRGN b);
export BOOL RectInRegion(HRGN r, RECT *);
export BOOL PtInRegion(HRGN r, int x, int y);
export int  OffsetRgn(HRGN r, int x, int y);
export HRGN CreatePolygonRgn(POINT *p, int n, int rule);
export HRGN CreateRectRgnIndirect(RECT *r);
export HRGN CreateEllipticRgnIndirect(RECT *r);
export HRGN CreateRoundRectRgn(int a, int b, int c, int d, int e, int f);
export int  CombineRgn(HRGN r, HRGN a, HRGN b, int n);
export int  GetRgnBox(HRGN r, LPRECT p);
export BOOL PaintRgn(HDC dc, HRGN r);
struct RGNDATAHEADER {
    DWORD   dwSize;
    DWORD   iType;
    DWORD   nCount;
    DWORD   nRgnSize;
    RECT    rcBound;
}
struct RGNDATA {
    RGNDATAHEADER   rdh;
    char            Buffer[1];
}
struct XFORM {
    FLOAT   eM11;
    FLOAT   eM12;
    FLOAT   eM21;
    FLOAT   eM22;
    FLOAT   eDx;
    FLOAT   eDy;
}
export DWORD GetRegionData(HRGN h, DWORD s, RGNDATA* data);
export HRGN ExtCreateRegion(XFORM *t, DWORD s, RGNDATA *data);

export int FillRect(HDC hDC,RECT *lprc,HBRUSH hbr);
export int FrameRect(HDC hDC,RECT *lprc,HBRUSH hbr);
export BOOL InvertRect(HDC hDC,RECT *lprc);
export BOOL IntersectRect(LPRECT lprcDst,RECT *lprcSrc1,RECT *lprcSrc2);
export BOOL UnionRect(LPRECT lprcDst,RECT *lprcSrc1,RECT *lprcSrc2);
export BOOL SubtractRect(LPRECT lprcDst,RECT *lprcSrc1,RECT *lprcSrc2);
export BOOL OffsetRect(LPRECT lprc,int dx,int dy);
export BOOL IsRectEmpty(RECT *lprc);
export BOOL EqualRect(RECT *lprc1,RECT *lprc2);
export BOOL PtInRect(RECT *lprc,POINT pt);

/* PolyFill() Modes */
enum {
  ALTERNATE = 1,
  WINDING =   2
}
export int SetPolyFillMode(HDC hdc, int m);
export int GetPolyFillMode(HDC hdc);

/*
 * Combo Box messages
 */
const uint CB_GETEDITSEL               =0x0140;
const uint CB_LIMITTEXT                =0x0141;
const uint CB_SETEDITSEL               =0x0142;
const uint CB_ADDSTRING                =0x0143;
const uint CB_DELETESTRING             =0x0144;
const uint CB_DIR                      =0x0145;
const uint CB_GETCOUNT                 =0x0146;
const uint CB_GETCURSEL                =0x0147;
const uint CB_GETLBTEXT                =0x0148;
const uint CB_GETLBTEXTLEN             =0x0149;
const uint CB_INSERTSTRING             =0x014A;
const uint CB_RESETCONTENT             =0x014B;
const uint CB_FINDSTRING               =0x014C;
const uint CB_SELECTSTRING             =0x014D;
const uint CB_SETCURSEL                =0x014E;
const uint CB_SHOWDROPDOWN             =0x014F;
const uint CB_GETITEMDATA              =0x0150;
const uint CB_SETITEMDATA              =0x0151;
const uint CB_GETDROPPEDCONTROLRECT    =0x0152;
const uint CB_SETITEMHEIGHT            =0x0153;
const uint CB_GETITEMHEIGHT            =0x0154;
const uint CB_SETEXTENDEDUI            =0x0155;
const uint CB_GETEXTENDEDUI            =0x0156;
const uint CB_GETDROPPEDSTATE          =0x0157;
const uint CB_FINDSTRINGEXACT          =0x0158;
const uint CB_SETLOCALE                =0x0159;
const uint CB_GETLOCALE                =0x015A;
const uint CB_GETTOPINDEX              =0x015b;
const uint CB_SETTOPINDEX              =0x015c;
const uint CB_GETHORIZONTALEXTENT      =0x015d;
const uint CB_SETHORIZONTALEXTENT      =0x015e;
const uint CB_GETDROPPEDWIDTH          =0x015f;
const uint CB_SETDROPPEDWIDTH          =0x0160;
const uint CB_INITSTORAGE              =0x0161;
const uint CBN_SELCHANGE       =1;
const uint CBN_DBLCLK          =2;
const uint CBN_SETFOCUS        =3;
const uint CBN_KILLFOCUS       =4;
const uint CBN_EDITCHANGE      =5;
const uint CBN_EDITUPDATE      =6;
const uint CBN_DROPDOWN        =7;
const uint CBN_CLOSEUP         =8;
const uint CBN_SELENDOK        =9;
const uint CBN_SELENDCANCEL    =10;

/*
 * Combo Box styles
 */
const uint CBS_SIMPLE            =0x0001L;
const uint CBS_DROPDOWN          =0x0002L;
const uint CBS_DROPDOWNLIST      =0x0003L;
const uint CBS_OWNERDRAWFIXED    =0x0010L;
const uint CBS_OWNERDRAWVARIABLE =0x0020L;
const uint CBS_AUTOHSCROLL       =0x0040L;
const uint CBS_OEMCONVERT        =0x0080L;
const uint CBS_SORT              =0x0100L;
const uint CBS_HASSTRINGS        =0x0200L;
const uint CBS_NOINTEGRALHEIGHT  =0x0400L;
const uint CBS_DISABLENOSCROLL   =0x0800L;
const uint CBS_UPPERCASE           =0x2000L;
const uint CBS_LOWERCASE           =0x4000L;

/*
 * Listbox messages
 */
const uint  LB_ADDSTRING            =0x0180;
const uint  LB_INSERTSTRING         =0x0181;
const uint  LB_DELETESTRING         =0x0182;
const uint  LB_SELITEMRANGEEX       =0x0183;
const uint  LB_RESETCONTENT         =0x0184;
const uint  LB_SETSEL               =0x0185;
const uint  LB_SETCURSEL            =0x0186;
const uint  LB_GETSEL               =0x0187;
const uint  LB_GETCURSEL            =0x0188;
const uint  LB_GETTEXT              =0x0189;
const uint  LB_GETTEXTLEN           =0x018A;
const uint  LB_GETCOUNT             =0x018B;
const uint  LB_SELECTSTRING         =0x018C;
const uint  LB_DIR                  =0x018D;
const uint  LB_GETTOPINDEX          =0x018E;
const uint  LB_FINDSTRING           =0x018F;
const uint  LB_GETSELCOUNT          =0x0190;
const uint  LB_GETSELITEMS          =0x0191;
const uint  LB_SETTABSTOPS          =0x0192;
const uint  LB_GETHORIZONTALEXTENT  =0x0193;
const uint  LB_SETHORIZONTALEXTENT  =0x0194;
const uint  LB_SETCOLUMNWIDTH       =0x0195;
const uint  LB_ADDFILE              =0x0196;
const uint  LB_SETTOPINDEX          =0x0197;
const uint  LB_GETITEMRECT          =0x0198;
const uint  LB_GETITEMDATA          =0x0199;
const uint  LB_SETITEMDATA          =0x019A;
const uint  LB_SELITEMRANGE         =0x019B;
const uint  LB_SETANCHORINDEX       =0x019C;
const uint  LB_GETANCHORINDEX       =0x019D;
const uint  LB_SETCARETINDEX        =0x019E;
const uint  LB_GETCARETINDEX        =0x019F;
const uint  LB_SETITEMHEIGHT        =0x01A0;
const uint  LB_GETITEMHEIGHT        =0x01A1;
const uint  LB_FINDSTRINGEXACT      =0x01A2;
const uint  LB_SETLOCALE            =0x01A5;
const uint  LB_GETLOCALE            =0x01A6;
const uint  LB_SETCOUNT             =0x01A7;
const uint  LB_INITSTORAGE          =0x01A8;
const uint  LB_ITEMFROMPOINT        =0x01A9;


/*
 * Listbox Styles
 */
const uint  LBS_NOTIFY            =0x0001L;
const uint  LBS_SORT              =0x0002L;
const uint  LBS_NOREDRAW          =0x0004L;
const uint  LBS_MULTIPLESEL       =0x0008L;
const uint  LBS_OWNERDRAWFIXED    =0x0010L;
const uint  LBS_OWNERDRAWVARIABLE =0x0020L;
const uint  LBS_HASSTRINGS        =0x0040L;
const uint  LBS_USETABSTOPS       =0x0080L;
const uint  LBS_NOINTEGRALHEIGHT  =0x0100L;
const uint  LBS_MULTICOLUMN       =0x0200L;
const uint  LBS_WANTKEYBOARDINPUT =0x0400L;
const uint  LBS_EXTENDEDSEL       =0x0800L;
const uint  LBS_DISABLENOSCROLL   =0x1000L;
const uint  LBS_NODATA            =0x2000L;
const uint  LBS_NOSEL             =0x4000L;
const uint  LBS_STANDARD          =(LBS_NOTIFY | LBS_SORT | WS_VSCROLL | WS_BORDER);

const uint OFN_READONLY                 =0x00000001;
const uint OFN_OVERWRITEPROMPT          =0x00000002;
const uint OFN_HIDEREADONLY             =0x00000004;
const uint OFN_NOCHANGEDIR              =0x00000008;
const uint OFN_SHOWHELP                 =0x00000010;
const uint OFN_ENABLEHOOK               =0x00000020;
const uint OFN_ENABLETEMPLATE           =0x00000040;
const uint OFN_ENABLETEMPLATEHANDLE     =0x00000080;
const uint OFN_NOVALIDATE               =0x00000100;
const uint OFN_ALLOWMULTISELECT         =0x00000200;
const uint OFN_EXTENSIONDIFFERENT       =0x00000400;
const uint OFN_PATHMUSTEXIST            =0x00000800;
const uint OFN_FILEMUSTEXIST            =0x00001000;
const uint OFN_CREATEPROMPT             =0x00002000;
const uint OFN_SHAREAWARE               =0x00004000;
const uint OFN_NOREADONLYRETURN         =0x00008000;
const uint OFN_NOTESTFILECREATE         =0x00010000;
const uint OFN_NONETWORKBUTTON          =0x00020000;
const uint OFN_NOLONGNAMES              =0x00040000;
const uint OFN_EXPLORER                 =0x00080000;
const uint OFN_NODEREFERENCELINKS       =0x00100000;
const uint OFN_LONGNAMES                =0x00200000;

const uint SBS_HORZ                    =0x0000;
const uint SBS_VERT                    =0x0001;
const uint SBS_TOPALIGN                =0x0002;
const uint SBS_LEFTALIGN               =0x0002;
const uint SBS_BOTTOMALIGN             =0x0004;
const uint SBS_RIGHTALIGN              =0x0004;
const uint SBS_SIZEBOXTOPLEFTALIGN     =0x0002;
const uint SBS_SIZEBOXBOTTOMRIGHTALIGN =0x0004;
const uint SBS_SIZEBOX                 =0x0008;

export HWND CreateWindowExW(
    DWORD dwExStyle,
    LPWSTR lpClassName,
    LPWSTR lpWindowName,
    DWORD dwStyle,
    int X,
    int Y,
    int nWidth,
    int nHeight,
    HWND hWndParent ,
    HMENU hMenu,
    HINSTANCE hInstance,
    LPVOID lpParam);


HWND CreateWindowW(
    LPWSTR lpClassName,
    LPWSTR lpWindowName,
    DWORD dwStyle,
    int X,
    int Y,
    int nWidth,
    int nHeight,
    HWND hWndParent ,
    HMENU hMenu,
    HINSTANCE hInstance,
    LPVOID lpParam)
{
    return CreateWindowExW(0, lpClassName, lpWindowName, dwStyle, X, Y, nWidth, nHeight, hWndParent, hMenu, hInstance, lpParam);
}

// PIXELFORMATDESCRIPTOR stuff
const uint PFD_TYPE_RGBA = 0;
const uint PFD_TYPE_COLORINDEX = 1;
const uint PFD_MAIN_PLANE = 0;
const uint PFD_OVERLAY_PLANE = 1;
const uint PFD_DOUBLEBUFFER = 1;
const uint PFD_STEREO = 2;
const uint PFD_DRAW_TO_WINDOW = 4;
const uint PFD_DRAW_TO_BITMAP = 8;
const uint PFD_SUPPORT_GDI = 16;
const uint PFD_SUPPORT_OPENGL = 32;
const uint PFD_GENERIC_FORMAT = 64;
const uint PFD_NEED_PALETTE = 128;
const uint PFD_NEED_SYSTEM_PALETTE = 0x00000100;
const uint PFD_SWAP_EXCHANGE = 0x00000200;
const uint PFD_SWAP_COPY = 0x00000400;
const uint PFD_SWAP_LAYER_BUFFERS = 0x00000800;
const uint PFD_GENERIC_ACCELERATED = 0x00001000;
const uint PFD_DEPTH_DONTCARE = 0x20000000;
const uint PFD_DOUBLEBUFFER_DONTCARE = 0x40000000;
const uint PFD_STEREO_DONTCARE = 0x80000000;

export int ChoosePixelFormat(HDC hdc, PIXELFORMATDESCRIPTOR* ppfd);
export int DescribePixelFormat(HDC hdc, int iPixelFormat, UINT nBytes, PIXELFORMATDESCRIPTOR* ppfd);

alias HANDLE HGLRC;

const int WGL_SWAP_MAIN_PLANE = 1;
//int wglUseFontOutlinesW(HDC, uint, uint, uint, float, float, int, _GLYPHMETRICSFLOAT *);
//int wglUseFontOutlinesA(HDC, uint, uint, uint, float, float, int, _GLYPHMETRICSFLOAT *);
//int wglUseFontBitmapsW(HDC, uint, uint, uint);
//int wglUseFontBitmapsA(HDC, uint, uint, uint);
//int wglSetLayerPaletteEntries(HDC, int, int, int, uint*);
//int wglRealizeLayerPalette(HDC, int, int);
//int wglGetLayerPaletteEntries(HDC, int, int, int, uint*);
//int wglDescribeLayerPlane(HDC*, int, int, uint, LAYERPLANEDESCRIPTOR *);
//HGLRC wglCreateLayerContext(HDC, int);
export int wglSwapLayerBuffers(HDC, uint);
export int wglShareLists(HGLRC, HGLRC);
export int wglMakeCurrent(HDC, HGLRC);
export void* wglGetProcAddress(char*);
export HDC wglGetCurrentDC();
export HGLRC wglGetCurrentContext();
export int wglDeleteContext(HGLRC);
export HGLRC wglCreateContext(HDC);
export int wglCopyContext(HGLRC, HGLRC, uint);

export BOOL SwapBuffers(HDC);

const int SM_CXBORDER = 5;
const int SM_CYBORDER = 5;
const int SM_CXFIXEDFRAME = 7;
const int SM_CYFIXEDFRAME = 8;
const int SM_CXEDGE = 45;
const int SM_CYEDGE= 46;
const int SM_CXMENUCHECK = 71;
const int SM_CYMENUCHECK = 72;

//
// these wrappers makes windows unicode look alot better and avoids excessive code duplication
package
{
    HWND CreateWindowX(
        char[] lpClassName,
        char[] lpWindowName,
        DWORD dwStyle,
        int X,
        int Y,
        int nWidth,
        int nHeight,
        HWND hWndParent ,
        HMENU hMenu,
        HINSTANCE hInstance,
        LPVOID lpParam)
    {
        if (useWfuncs)
        return CreateWindowExW(0, toUTF16z(lpClassName), toUTF16z(lpWindowName), dwStyle, X, Y, nWidth, nHeight, hWndParent, hMenu, hInstance, lpParam);
        else
        return CreateWindowExA(0, toMBSz(lpClassName), toMBSz(lpWindowName), dwStyle, X, Y, nWidth, nHeight, hWndParent, hMenu, hInstance, lpParam);
    }

    BOOL SendMessageX(HWND hWnd, UINT msg, WPARAM wParam, char[] lParam)
    {
        if (useWfuncs)
        return SendMessageW(hWnd, msg, wParam, cast(LPARAM)toUTF16z(lParam));
        else
        return SendMessageW(hWnd, msg, wParam, cast(LPARAM)toMBSz(lParam));
    }

    int MessageBoxX(HWND hWnd, char[] lpText, char[] lpCaption, UINT uType)
    {
        if (useWfuncs)
        return MessageBoxW(hWnd, toUTF16z(lpText), toUTF16z(lpCaption), uType);
        else
        return MessageBoxA(hWnd, toMBSz(lpText), toMBSz(lpCaption), uType);
    }

    BOOL GetTextExtentPoint32X(HDC dc, char[] str, int len, SIZE* s)
    {
        if (useWfuncs) {
            wchar[] wstr = toUTF16(str);
            return GetTextExtentPoint32W(dc, wstr.ptr, wstr.length, s);
        } else {
            size_t al;
            char* ansi = toMBSzl(str, al);
            return GetTextExtentPoint32A(dc, ansi, al, s);
        }
    }

    BOOL AppendMenuX(HMENU menu, uint flags, void*item, char[] str)
    {
        if (useWfuncs)
        return AppendMenuW(menu, flags, item, toUTF16z(str));
        else
        return AppendMenuA(menu, flags, item, toMBSz(str));
    }
}

/******************************************
 * Converts the UTF-8 string s into a null-terminated string in a Windows
 * 8-bit character set.
 *
 * Params:
 * s = UTF-8 string to convert.
 * reslen = the number of bytes in the resulting buffer
 *   (not including the null terminator) will be place here.
 * codePage = is the number of the target codepage, or
 *   0 - ANSI,
 *   1 - OEM,
 *   2 - Mac
 *
 * Authors:
 *	yaneurao, Walter Bright, Stewart Gordon
 */
private import std.windows.syserror;
char* toMBSzl(char[] s, out size_t reslen, uint codePage = 0)
{
    // Only need to do this if any chars have the high bit set
    foreach (char c; s)
    {
    	if (c >= 0x80)
    	{
    	    char[] result;
    	    int readLen;
    	    wchar* ws = std.utf.toUTF16z(s);
    	    result.length = WideCharToMultiByte(codePage, 0, ws, -1, null, 0,
    		null, null);

    	    if (result.length)
    	    {
    		readLen = WideCharToMultiByte(codePage, 0, ws, -1, result.ptr,
    			result.length, null, null);
    	    }

    	    if (!readLen || readLen != result.length)
    	    {
    		throw new Exception("Couldn't convert string: " ~
    			sysErrorString(GetLastError()));
    	    }

    	    reslen = result.length ? result.length-1 : 0;
    	    return result.ptr;
    	}
    }
    reslen = s.length;
    return std.string.toStringz(s);
}
