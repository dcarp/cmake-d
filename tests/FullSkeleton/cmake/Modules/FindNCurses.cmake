#------------------------------------------------------------------------------
# Desc:
# Tabs: 3
#
# Copyright (c) 2007 Novell, Inc. All Rights Reserved.
#
# This program and the accompanying materials are made available 
# under the terms of the Eclipse Public License v1.0 which
# accompanies this distribution, and is available at 
# http://www.eclipse.org/legal/epl-v10.html
#
# To contact Novell about this file by physical or electronic mail, 
# you may find current contact information at www.novell.com.
#
# $Id$
#
# Author: Andrew Hodgkinson <ahodgkinson@novell.com>
#------------------------------------------------------------------------------

# Include the local modules directory

set( CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMakeModules")

# Locate ncurses files

if( NOT NCURSES_FOUND)

	find_path( NCURSES_INCLUDE_DIR ncurses.h 
		PATHS /usr/include
				/usr/local/include
		NO_DEFAULT_PATH
	)
	MARK_AS_ADVANCED( NCURSES_INCLUDE_DIR)
		
	find_library( NCURSES_LIBRARY 
		NAMES ncurses 
		PATHS /usr/lib
				/usr/local/lib
		NO_DEFAULT_PATH
	) 
	MARK_AS_ADVANCED( NCURSES_LIBRARY)
		
	if( NCURSES_INCLUDE_DIR AND NCURSES_LIBRARY)
		set( NCURSES_FOUND TRUE)
		set( NCURSES_INCLUDE_DIRS ${NCURSES_INCLUDE_DIR})
		set( NCURSES_LIBRARIES ${NCURSES_LIBRARY})
	endif( NCURSES_INCLUDE_DIR AND NCURSES_LIBRARY)
	
	if( NCURSES_FOUND)
		if( NOT NCURSES_FIND_QUIETLY)
			message( STATUS "Found ncurses libraries: ${NCURSES_LIBRARIES}")
			message( STATUS "Found ncurses inc dirs: ${NCURSES_INCLUDE_DIRS}")
		endif( NOT NCURSES_FIND_QUIETLY)
	else( NCURSES_FOUND)
		if( NCURSES_FIND_REQUIRED)
			message( FATAL_ERROR "Could not find ncurses")
		else( NCURSES_FIND_REQUIRED)
			if( NOT NCURSES_FIND_QUIETLY)
				message( STATUS "Could not find ncurses")
			endif( NOT NCURSES_FIND_QUIETLY)
		endif( NCURSES_FIND_REQUIRED)
	endif( NCURSES_FOUND)

endif( NOT NCURSES_FOUND)

