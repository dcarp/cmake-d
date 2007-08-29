#################################
# Includes
##############

INCLUDE(CheckIncludeFile)
INCLUDE(CheckSymbolExists)
INCLUDE(CheckFunctionExists)
INCLUDE(CheckLibraryExists)
INCLUDE(CheckTypeSize)
INCLUDE(CheckCXXSourceCompiles)

#################################
# Defines
##############

SET(PACKAGE ${APPLICATION_NAME})
SET(VERSION ${APPLICATION_VERSION})
SET(PREFIX ${CMAKE_INSTALL_PREFIX})
SET(DATADIR ${DATA_INSTALL_DIR})
SET(LIBDIR ${LIB_INSTALL_DIR})
SET(PLUGINDIR ${PLUGIN_INSTALL_DIR})
SET(SYSCONFDIR ${SYSCONF_INSTALL_DIR})

#################################
# Check for desired renderer plugins
##############

# x11 renderer
IF(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
	set(BUILD_RENDERER_X11 False CACHE BOOLEAN TRUE FORCE)
ELSE(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
	if (NOT BUILD_RENDERER_X11)
		set(BUILD_RENDERER_X11 True CACHE BOOLEAN TRUE FORCE)
	endif (NOT BUILD_RENDERER_X11)
ENDIF(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")

# windows renderer
IF(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
	if (NOT BUILD_RENDERER_WIN)
		set(BUILD_RENDERER_WIN True CACHE BOOLEAN TRUE FORCE)
	endif (NOT BUILD_RENDERER_WIN)
ELSE(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
	set(BUILD_RENDERER_WIN False CACHE BOOLEAN TRUE FORCE)
ENDIF(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")

# client
if (NOT BUILD_CLIENT)
	set(BUILD_CLIENT True CACHE BOOLEAN TRUE FORCE)
endif (NOT BUILD_CLIENT)

# server
if (NOT BUILD_SERVER)
	set(BUILD_SERVER True CACHE BOOLEAN TRUE FORCE)
endif (NOT BUILD_SERVER)

#################################
# openpty / forkpty
##############

IF(NOT ${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
	check_function_exists(openpty		HAVE_OPENPTY)		# openpty
	if (NOT HAVE_OPENPTY)
		check_library_exists(util openpty "" HAVE_LIBUTIL)
		if (HAVE_LIBUTIL)
			set(HAVE_OPENPTY True)
			set(LIBUTIL_LIBRARIES "util")
		else (HAVE_LIBUTIL)
			message(FATAL_ERROR "You must have openpty in libutil!")
		endif (HAVE_LIBUTIL)
	endif (NOT HAVE_OPENPTY)
ENDIF(NOT ${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
