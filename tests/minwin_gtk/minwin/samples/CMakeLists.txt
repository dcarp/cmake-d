SET(CMAKE_FIND_LIBRARY_PREFIXES "")
SET(CMAKE_FIND_LIBRARY_SUFFIXES ".so")

FIND_PACKAGE (GTK2)

IF (GTK2_FOUND)
  INCLUDE_DIRECTORIES (${minwin_gtk_SOURCE_DIR} ${GTK2_INCLUDE_DIRS})
  LINK_DIRECTORIES (${minwin_gtk_SOURCE_DIR} ${GTK2_LIBRARY_DIRS})

  ADD_EXECUTABLE (sample sample.d)
  TARGET_LINK_LIBRARIES (sample minwin_gtk)

  ADD_EXECUTABLE (layout layout.d)
  TARGET_LINK_LIBRARIES (layout minwin_gtk)

  ADD_EXECUTABLE (topgroup topgroup.d)
  TARGET_LINK_LIBRARIES (topgroup minwin_gtk)

  ADD_EXECUTABLE (widgets widgets.d)
  TARGET_LINK_LIBRARIES (widgets minwin_gtk)

  ADD_EXECUTABLE (menus menus.d)
  TARGET_LINK_LIBRARIES (menus minwin_gtk)

  ADD_EXECUTABLE (painting painting.d)
  TARGET_LINK_LIBRARIES (painting minwin_gtk)

  ADD_EXECUTABLE (sdialog sdialog.d)
  TARGET_LINK_LIBRARIES (sdialog minwin_gtk)

  ADD_EXECUTABLE (sdialog2 sdialog2.d)
  TARGET_LINK_LIBRARIES (sdialog2 minwin_gtk)

  ADD_EXECUTABLE (idle idle.d)
  TARGET_LINK_LIBRARIES (idle minwin_gtk)

ENDIF (GTK2_FOUND)