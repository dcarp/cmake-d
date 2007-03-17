SET(CMAKE_FIND_LIBRARY_PREFIXES "")
SET(CMAKE_FIND_LIBRARY_SUFFIXES ".so")

PROJECT (minwin_gtk D)

FIND_PACKAGE (GTK2)

IF (GTK2_FOUND)
  
  INCLUDE_DIRECTORIES ( ${GTK2_INCLUDE_DIRS} )
  
  
  SET (SRCS
    minwin/all.d        minwin/font.d       minwin/layout.d     minwin/peerimpl.d
    minwin/app.d        minwin/geometry.d   minwin/listbox.d    minwin/scroll.d
    minwin/button.d     minwin/group.d      minwin/logging.d    minwin/text.d
    minwin/canvas.d     minwin/gtk.d        minwin/menu.d       minwin/unittest.d
    minwin/combo.d      minwin/gtk_peers.d                      minwin/window.d
    minwin/component.d  minwin/icon.d       minwin/multidg.d
    minwin/dialog.d     minwin/image.d      minwin/paint.d
    minwin/event.d      minwin/label.d      minwin/peer.d )
  
  ADD_DEFINITIONS (-fversion=GTK ${GTK2_DEFINITIONS})
  
  ADD_LIBRARY (minwin_gtk ${SRCS})
  
  TARGET_LINK_LIBRARIES (minwin_gtk ${GTK2_LIBRARIES})
  
  ADD_SUBDIRECTORY (minwin/samples)

ENDIF (GTK2_FOUND)
