
# To build the samples type "make -f win32.mak"

#VER = Motif
#LIB = libminwin_motif.a
#XLIBS = -L-L/usr/X11R6/lib -L-lXm -L-lXt -L-lX11 -L-lImlib

VER = GTK
LIB = libminwin_gtk.a
XLIBS = -L-L/usr/X11R6/lib -L-lgtk-x11-2.0 -L-lX11

DMD = dmd

TARGETS= sample layout topgroup \
  widgets menus painting sdialog sdialog2 idle

targets : $(TARGETS)

% : %.d
	$(DMD) -g ../$(LIB) -I../.. $(XLIBS) -version=$(VER) -of$@ $< -version=LOG

clean:
	- rm *.o $(TARGETS)
