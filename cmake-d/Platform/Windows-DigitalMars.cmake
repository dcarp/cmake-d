#
# CMakeD - CMake module for D Language
#
# Copyright (c) 2007, Selman Ulug <selman.ulug@gmail.com>
#                     Tim Burrell <tim.burrell@gmail.com>
#
# All rights reserved.
#
# See LICENSE for details.
#
# Modified from CMake 2.6.5 gcc.cmake
# See http://www.cmake.org/HTML/Copyright.html for details
#

#set(DSTDLIB_FLAGS "-version=Phobos")
IF(CMAKE_D_BUILD_DOCS)
  set(DDOC_FLAGS "-D -Dddocumentation")
  # foreach(item ${CMAKE_D_DDOC_FILES})
  #  set(DDOC_FLAGS "${DDOC_FLAGS} ${item}")
  # endforeach()
endif()

set(CMAKE_D_OUTPUT_EXTENSION .obj)
set(CMAKE_D_DASH_O "-of")
set(CMAKE_BASE_NAME dmd)

set(CMAKE_STATIC_LIBRARY_CREATE_D_FLAGS "-lib")

set(CMAKE_SHARED_LIBRARY_D_FLAGS "")            # -pic
set(CMAKE_SHARED_LIBRARY_CREATE_D_FLAGS "-shared")       # -shared
set(CMAKE_SHARED_LIBRARY_LINK_D_FLAGS "")         # +s, flag for exe link to use shared lib
set(CMAKE_SHARED_LIBRARY_RUNTIME_D_FLAG "")       # -rpath
set(CMAKE_SHARED_LIBRARY_RUNTIME_D_FLAG_SEP "")   # : or empty
set(CMAKE_INCLUDE_FLAG_D "-I")       # -I
set(CMAKE_INCLUDE_FLAG_D_SEP "")     # , or empty
set(CMAKE_LIBRARY_PATH_FLAG "-L-L")
set(CMAKE_LIBRARY_PATH_TERMINATOR "")  # for the Digital Mars D compiler the link paths have to be terminated with a "/"

set(CMAKE_LINK_LIBRARY_FLAG "-L-l")
set(CMAKE_STATIC_LIBRARY_PREFIX "")				#
set(CMAKE_STATIC_LIBRARY_SUFFIX ".lib")			# lib
set(CMAKE_SHARED_LIBRARY_PREFIX "")          	#
set(CMAKE_SHARED_LIBRARY_SUFFIX ".dll")         # .dll
set(CMAKE_EXECUTABLE_SUFFIX ".exe")          	# .exe
set(CMAKE_DL_LIBS "dl")

set(CMAKE_FIND_LIBRARY_PREFIXES "")
set(CMAKE_FIND_LIBRARY_SUFFIXES ".lib" ".dll")

set(CMAKE_D_FLAGS_INIT "")
# DMD can only produce 32-bit binaries for now
set(CMAKE_D_LINK_FLAGS "")
set(CMAKE_D_FLAGS_DEBUG_INIT "-g -debug ${DDOC_FLAGS}")
set(CMAKE_D_FLAGS_RELEASE_INIT "-O -release -inline ${DDOC_FLAGS}")
set(CMAKE_D_FLAGS_RELWITHDEBINFO_INIT "-O -g ${DDOC_FLAGS}")
set(CMAKE_D_CREATE_ASSEMBLY_SOURCE "<CMAKE_D_COMPILER> <FLAGS> -S <SOURCE> -of<ASSEMBLY_SOURCE>")
set(CMAKE_D_VERSION_FLAG "-version=")
set(CMAKE_DEPFILE_FLAGS_D "-makedeps=<DEP_FILE>")
set(CMAKE_LINKER_FLAG_PREFIX "-L=")
