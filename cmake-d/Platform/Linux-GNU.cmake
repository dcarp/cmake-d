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

set(CMAKE_D_OUTPUT_EXTENSION .o)
set(CMAKE_D_DASH_O "-o")
set(CMAKE_BASE_NAME gdc)

if(CMAKE_D_USE_TANGO)
  set(DSTDLIB_FLAGS "-fversion=Tango")
endif()
if(CMAKE_D_USE_PHOBOS)
  set(DSTDLIB_FLAGS "-fversion=Phobos")
endif()
if(CMAKE_D_BUILD_DOCS)
  set(DDOC_FLAGS "-fdoc -fdoc-dir=documentation")
  foreach(item ${CMAKE_D_DDOC_FILES})
    set(DDOC_FLAGS "${DDOC_FLAGS} -fdoc-inc=${item}")
  endforeach()
endif()

set(CMAKE_SHARED_LIBRARY_D_FLAGS "-fPIC")            # -pic
set(CMAKE_SHARED_LIBRARY_CREATE_D_FLAGS "-shared")       # -shared
set(CMAKE_SHARED_LIBRARY_LINK_D_FLAGS "")         # +s, flag for exe link to use shared lib
set(CMAKE_SHARED_LIBRARY_RUNTIME_D_FLAG "")       # -rpath
set(CMAKE_SHARED_LIBRARY_RUNTIME_D_FLAG_SEP "")   # : or empty
set(CMAKE_INCLUDE_FLAG_D "-I")       # -I
set(CMAKE_INCLUDE_FLAG_D_SEP "")     # , or empty
set(CMAKE_LIBRARY_PATH_FLAG "-L")
set(CMAKE_LIBRARY_PATH_TERMINATOR "")  # for the Digital Mars D compiler the link paths have to be terminated with a "/"
set(CMAKE_LINK_LIBRARY_FLAG "-l")

set(CMAKE_LINK_LIBRARY_SUFFIX "")
set(CMAKE_STATIC_LIBRARY_PREFIX "lib")
set(CMAKE_STATIC_LIBRARY_SUFFIX ".a")
set(CMAKE_SHARED_LIBRARY_PREFIX "lib")          # lib
set(CMAKE_SHARED_LIBRARY_SUFFIX ".so")          # .so
set(CMAKE_EXECUTABLE_SUFFIX "")          # .exe
set(CMAKE_DL_LIBS "dl")

# SET(CMAKE_D_FLAGS_INIT "-fversion=Posix -fversion=${CMAKE_BUILD_TYPE}Build ${DSTDLIB_FLAGS}")
set(CMAKE_D_FLAGS_INIT "-fall-instantiations ")
set(CMAKE_D_FLAGS_DEBUG_INIT "-g ${DDOC_FLAGS}")
set(CMAKE_D_FLAGS_MINSIZEREL_INIT "-Os ${DDOC_FLAGS}")
set(CMAKE_D_FLAGS_RELEASE_INIT "-O3 -fomit-frame-pointer -fweb -frelease -finline-functions ${DDOC_FLAGS}")
set(CMAKE_D_FLAGS_RELWITHDEBINFO_INIT "-O2 -g ${DDOC_FLAGS}")
# set(CMAKE_D_CREATE_PREPROCESSED_SOURCE "<CMAKE_D_COMPILER> <FLAGS> -E <SOURCE> > <PREPROCESSED_SOURCE>")
set(CMAKE_D_CREATE_ASSEMBLY_SOURCE "<CMAKE_D_COMPILER> <FLAGS> -S <SOURCE> -o <ASSEMBLY_SOURCE>")
# set(CMAKE_INCLUDE_SYSTEM_FLAG_D "-isystem ")
set(CMAKE_LINKER_FLAG_PREFIX "-Wl,")

set(CMAKE_INCLUDE_FLAG_D "-I")       # -I
set(CMAKE_D_VERSION_FLAG "-fversion=")
set(CMAKE_DEPFILE_FLAGS_D "-MD -MT <DEP_TARGET> -MF <DEP_FILE>")
