
# To build minwin.lib type "make -f win32.mak"
# The minwin.lib and object files will be created in the source directory.

# flags to use building unittest.exe
DUNITFLAGS=-g -unittest -I..

# flags to use when building the minwi.lib library
#DLIBFLAGS=-O -release -I.. 
DLIBFLAGS=-g -I.. 

DMD = dmd
LIB = lib

targets : minwin

#unittest : unittest.exe

LIBNAME = minwin.lib

minwin : $(LIBNAME)

SRC = app.d \
	window.d \
	peerimpl.d \
	paint.d \
	font.d \
	logging.d \
	geometry.d \
	mswindows.d \
	multidg.d \
	component.d \
	button.d \
	menu.d \
	event.d \
	icon.d \
	dialog.d \
	group.d \
	image.d \
	peer.d \
	label.d \
	text.d \
	combo.d \
	listbox.d \
	canvas.d \
	scroll.d \
	layout.d

OBJS = app.obj \
	window.obj \
	peerimpl.obj \
	paint.obj \
	font.obj \
	logging.obj \
	geometry.obj \
	mswindows.obj \
	multidg.obj \
	component.obj \
	button.obj \
	menu.obj \
	event.obj \
	icon.obj \
	dialog.obj \
	group.obj \
	image.obj \
	peer.obj \
	label.obj \
	text.obj \
	combo.obj \
	listbox.obj \
	canvas.obj \
	scroll.obj \
	layout.obj

.d.obj :
	$(DMD) -c $(DLIBFLAGS) -of$@ $<

$(LIBNAME) : $(OBJS) $(SRC)
	$(LIB) -c $@ $(OBJS)

#unittest.exe : $(LIBNAME) $(SRC)
#	$(DMD) $(DUNITFLAGS) unittest.d -ofunittest.exe $(SRC)

clean:
	- del *.obj
	- del $(LIBNAME)
	- del unittest.exe
