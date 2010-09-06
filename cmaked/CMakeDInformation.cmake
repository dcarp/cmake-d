#
# CMakeD - CMake module for D Language
#
# Copyright (c) 2007, Selman Ulug <selman.ulug@gmail.com>
#                     Tim Burrell <tim.burrell@gmail.com>
#                     Steve King <sk@metrokings.com>
#
# All rights reserved.
#
# See Copyright.txt for details.
#
# Modified from CMake 2.6.5 CMakeCInformation.cmake
# See http://www.cmake.org/HTML/Copyright.html for details
#

# This file sets the basic flags for the D language in CMake.
# It also loads the available platform file for the system-compiler
# if it exists.
# It also loads a system - compiler - processor (or target hardware)
# specific file, which is mainly useful for crosscompiling and embedded systems.

MESSAGE( "**** Debug Info: Enter CMakeDInformation.cmake" )
# Load compiler-specific information.

SET( _INCLUDED_FILE 0 )  # reset the indicator if an include occurred.

IF(CMAKE_D_COMPILER_ID)
  INCLUDE(Compiler/${CMAKE_D_COMPILER_ID}-D OPTIONAL)
ENDIF(CMAKE_D_COMPILER_ID)

# SET(CMAKE_D_OUTPUT_EXTENSION .o)
SET(CMAKE_C_OUTPUT_EXTENSION_REPLACE TRUE )
SET(CMAKE_D_OUTPUT_EXTENSION_REPLACE TRUE )

SET(CMAKE_BASE_NAME)
GET_FILENAME_COMPONENT(CMAKE_BASE_NAME ${CMAKE_D_COMPILER} NAME_WE)

SET( _INCLUDED_FILE 0 )  # reset the indicator if an include occurred.

# load a hardware specific file, mostly useful for embedded compilers
IF(CMAKE_SYSTEM_PROCESSOR)
  IF(CMAKE_D_COMPILER_ID)
    INCLUDE(Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_D_COMPILER_ID}-D-${CMAKE_SYSTEM_PROCESSOR} OPTIONAL RESULT_VARIABLE _INCLUDED_FILE)
  ENDIF(CMAKE_D_COMPILER_ID)
  IF (NOT _INCLUDED_FILE)
    INCLUDE(Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_BASE_NAME}-${CMAKE_SYSTEM_PROCESSOR} OPTIONAL)
  ENDIF (NOT _INCLUDED_FILE)
ENDIF(CMAKE_SYSTEM_PROCESSOR)

MESSAGE( "**** Debug Info: CMAKE_SYSTEM_NAME = ${CMAKE_SYSTEM_NAME}" )
MESSAGE( "**** Debug Info: CMAKE_D_COMPILER_ID = ${CMAKE_D_COMPILER_ID}" )
MESSAGE( "**** Debug Info: CMAKE_BASE_NAME = ${CMAKE_BASE_NAME}" )

SET( _INCLUDED_FILE 0 )  # reset the indicator if an include occurred.

# load the system- and compiler specific files
IF(CMAKE_D_COMPILER_ID)
  INCLUDE(Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_D_COMPILER_ID}-D
    OPTIONAL RESULT_VARIABLE _INCLUDED_FILE)
ENDIF(CMAKE_D_COMPILER_ID)

# if no high specificity file was included, then try a more general one
IF (NOT _INCLUDED_FILE)
  INCLUDE(Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_BASE_NAME}
    OPTIONAL RESULT_VARIABLE _INCLUDED_FILE)
ENDIF (NOT _INCLUDED_FILE)

# We specify the compiler information in the system file for some
# platforms, but this language may not have been enabled when the file
# was first included.  Include it again to get the language info.
# Remove this when all compiler info is removed from system files.
IF (NOT _INCLUDED_FILE)
  INCLUDE(Platform/${CMAKE_SYSTEM_NAME} OPTIONAL)
ENDIF (NOT _INCLUDED_FILE)


# This should be included before the _INIT variables are
# used to initialize the cache.  Since the rule variables
# have if blocks on them, users can still define them here.
# But, it should still be after the platform file so changes can
# be made to those values.

IF(CMAKE_USER_MAKE_RULES_OVERRIDE)
   INCLUDE(${CMAKE_USER_MAKE_RULES_OVERRIDE})
ENDIF(CMAKE_USER_MAKE_RULES_OVERRIDE)

IF(CMAKE_USER_MAKE_RULES_OVERRIDE_D)
   INCLUDE(${CMAKE_USER_MAKE_RULES_OVERRIDE_D})
ENDIF(CMAKE_USER_MAKE_RULES_OVERRIDE_D)

# for most systems a module is the same as a shared library
# so unless the variable CMAKE_MODULE_EXISTS is set just
# copy the values from the LIBRARY variables
IF(NOT CMAKE_MODULE_EXISTS)
  SET(CMAKE_SHARED_MODULE_D_FLAGS ${CMAKE_SHARED_LIBRARY_D_FLAGS})
  SET(CMAKE_SHARED_MODULE_CREATE_D_FLAGS ${CMAKE_SHARED_LIBRARY_CREATE_D_FLAGS})
ENDIF(NOT CMAKE_MODULE_EXISTS)

SET(CMAKE_D_FLAGS_INIT "$ENV{DFLAGS} ${CMAKE_D_FLAGS_INIT}")
# avoid just having a space as the initial value for the cache
IF(CMAKE_D_FLAGS_INIT STREQUAL " ")
  SET(CMAKE_D_FLAGS_INIT)
ENDIF(CMAKE_D_FLAGS_INIT STREQUAL " ")
SET (CMAKE_D_FLAGS "${CMAKE_D_FLAGS_INIT}" CACHE STRING
     "Flags used by the D compiler during all build types.")

IF(NOT CMAKE_NOT_USING_CONFIG_FLAGS)
# default build type is none
  IF(NOT CMAKE_NO_BUILD_TYPE)
    SET (CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE_INIT} CACHE STRING
      "Choose the type of build, options are: None(CMAKE_D_FLAGS used) Debug Release RelWithDebInfo MinSizeRel.")
  ENDIF(NOT CMAKE_NO_BUILD_TYPE)
  SET (CMAKE_D_FLAGS_DEBUG "${CMAKE_D_FLAGS_DEBUG_INIT}" CACHE STRING
    "Flags used by the compiler during debug builds.")
  SET (CMAKE_D_FLAGS_MINSIZEREL "${CMAKE_D_FLAGS_MINSIZEREL_INIT}" CACHE STRING
    "Flags used by the compiler during release minsize builds.")
  SET (CMAKE_D_FLAGS_RELEASE "${CMAKE_D_FLAGS_RELEASE_INIT}" CACHE STRING
    "Flags used by the compiler during release builds (/MD /Ob1 /Oi /Ot /Oy /Gs will produce slightly less optimized but smaller files).")
  SET (CMAKE_D_FLAGS_RELWITHDEBINFO "${CMAKE_D_FLAGS_RELWITHDEBINFO_INIT}" CACHE STRING
    "Flags used by the compiler during Release with Debug Info builds.")
ENDIF(NOT CMAKE_NOT_USING_CONFIG_FLAGS)

IF(CMAKE_D_STANDARD_LIBRARIES_INIT)
  SET(CMAKE_D_STANDARD_LIBRARIES "${CMAKE_D_STANDARD_LIBRARIES_INIT}"
    CACHE STRING "Libraries linked by default with all D applications.")
  MARK_AS_ADVANCED(CMAKE_D_STANDARD_LIBRARIES)
ENDIF(CMAKE_D_STANDARD_LIBRARIES_INIT)

INCLUDE(CMakeCommonLanguageInclude)

# now define the following rule variables

# CMAKE_D_CREATE_SHARED_LIBRARY
# CMAKE_D_CREATE_SHARED_MODULE
# CMAKE_D_CREATE_STATIC_LIBRARY
# CMAKE_D_COMPILE_OBJECT
# CMAKE_D_LINK_EXECUTABLE

# variables supplied by the generator at use time
# <TARGET>
# <TARGET_BASE> the target without the suffix
# <OBJECTS>
# <OBJECT>
# <LINK_LIBRARIES>
# <FLAGS>
# <LINK_FLAGS>

# D compiler information
# <CMAKE_D_COMPILER>
# <CMAKE_SHARED_LIBRARY_CREATE_D_FLAGS>
# <CMAKE_SHARED_MODULE_CREATE_D_FLAGS>
# <CMAKE_D_LINK_FLAGS>

# Static library tools
# <CMAKE_AR>
# <CMAKE_RANLIB>


# create a D shared library
IF(NOT CMAKE_D_CREATE_SHARED_LIBRARY)
	SET(CMAKE_D_CREATE_SHARED_LIBRARY
		"<CMAKE_D_COMPILER> <CMAKE_SHARED_LIBRARY_D_FLAGS> <LANGUAGE_COMPILE_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_LIBRARY_CREATE_D_FLAGS> <CMAKE_SHARED_LIBRARY_SONAME_D_FLAG><TARGET_SONAME> ${CMAKE_D_DASH_O}<TARGET> <OBJECTS> <LINK_LIBRARIES> ${DSTDLIB_FLAGS} ${CMAKE_D_STDLIBS}")
ENDIF(NOT CMAKE_D_CREATE_SHARED_LIBRARY)

# create a D shared module just copy the shared library rule
IF(NOT CMAKE_D_CREATE_SHARED_MODULE)
  SET(CMAKE_D_CREATE_SHARED_MODULE ${CMAKE_D_CREATE_SHARED_LIBRARY})
ENDIF(NOT CMAKE_D_CREATE_SHARED_MODULE)
IF(NOT CMAKE_D_CREATE_STATIC_LIBRARY)
	SET(CMAKE_D_CREATE_STATIC_LIBRARY
		"<CMAKE_D_COMPILER> -lib <OBJECTS> ${CMAKE_D_DASH_O}<TARGET>")
ENDIF(NOT CMAKE_D_CREATE_STATIC_LIBRARY)


# Create a static archive incrementally for large object file counts.
# If CMAKE_D_CREATE_STATIC_LIBRARY is set it will override these.
SET(CMAKE_D_ARCHIVE_CREATE "<CMAKE_AR> cr <TARGET> <LINK_FLAGS> <OBJECTS>")
SET(CMAKE_D_ARCHIVE_APPEND "<CMAKE_AR> r  <TARGET> <LINK_FLAGS> <OBJECTS>")
SET(CMAKE_D_ARCHIVE_FINISH "<CMAKE_RANLIB> <TARGET>")

# compile a D file into an object file
IF(NOT CMAKE_D_COMPILE_OBJECT)
    SET(CMAKE_D_COMPILE_OBJECT
     "<CMAKE_D_COMPILER> <FLAGS> -od${CMAKE_CURRENT_BINARY_DIR}/ ${CMAKE_D_DASH_O}<OBJECT> -c <SOURCE>")
ENDIF(NOT CMAKE_D_COMPILE_OBJECT)

IF(NOT CMAKE_D_LINK_EXECUTABLE)
  SET(CMAKE_D_LINK_EXECUTABLE
    "<CMAKE_D_COMPILER> <FLAGS> <CMAKE_D_LINK_FLAGS> <OBJECTS> ${CMAKE_D_DASH_O}<TARGET> <LINK_LIBRARIES> ${CMAKE_D_STDLIBS}")
ENDIF(NOT CMAKE_D_LINK_EXECUTABLE)

IF(NOT CMAKE_EXECUTABLE_RUNTIME_D_FLAG)
  SET(CMAKE_EXECUTABLE_RUNTIME_D_FLAG ${CMAKE_SHARED_LIBRARY_RUNTIME_D_FLAG})
ENDIF(NOT CMAKE_EXECUTABLE_RUNTIME_D_FLAG)

IF(NOT CMAKE_EXECUTABLE_RUNTIME_D_FLAG_SEP)
  SET(CMAKE_EXECUTABLE_RUNTIME_D_FLAG_SEP ${CMAKE_SHARED_LIBRARY_RUNTIME_D_FLAG_SEP})
ENDIF(NOT CMAKE_EXECUTABLE_RUNTIME_D_FLAG_SEP)

IF(NOT CMAKE_EXECUTABLE_RPATH_LINK_D_FLAG)
  SET(CMAKE_EXECUTABLE_RPATH_LINK_D_FLAG ${CMAKE_SHARED_LIBRARY_RPATH_LINK_D_FLAG})
ENDIF(NOT CMAKE_EXECUTABLE_RPATH_LINK_D_FLAG)

MARK_AS_ADVANCED(
CMAKE_D_FLAGS
CMAKE_D_FLAGS_DEBUG
CMAKE_D_FLAGS_MINSIZEREL
CMAKE_D_FLAGS_RELEASE
CMAKE_D_FLAGS_RELWITHDEBINFO
)
SET(CMAKE_D_INFORMATION_LOADED 1)
MESSAGE( "**** Debug Info: Exit CMakeDInformation.cmake" )
