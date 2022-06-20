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
if(CMAKE_D_BUILD_DOCS)
  set(DDOC_FLAGS "-D -Dddocumentation")
  # foreach(item ${CMAKE_D_DDOC_FILES})
  #  set(DDOC_FLAGS "${DDOC_FLAGS} ${item}")
  # endforeach()
endif()

set(CMAKE_D_OUTPUT_EXTENSION .o)
set(CMAKE_D_DASH_O "-of")
set(CMAKE_BASE_NAME dmd)

set(CMAKE_STATIC_LIBRARY_CREATE_D_FLAGS "-lib")

set(CMAKE_SHARED_LIBRARY_D_FLAGS "")            # -pic
set(CMAKE_SHARED_LIBRARY_CREATE_D_FLAGS "-shared -defaultlib=libphobos2.so")       # -shared
set(CMAKE_SHARED_LIBRARY_LINK_D_FLAGS "")         # +s, flag for exe link to use shared lib
set(CMAKE_SHARED_LIBRARY_RUNTIME_D_FLAG "")       # -rpath
set(CMAKE_SHARED_LIBRARY_RUNTIME_D_FLAG_SEP "")   # : or empty
set(CMAKE_SHARED_LIBRARY_SONAME_D_FLAG "-L-soname=")
set(CMAKE_SHARED_LIBRARY_RPATH_LINK_D_FLAG "-L-rpath=")
set(CMAKE_INCLUDE_FLAG_D "-I")       # -I
set(CMAKE_INCLUDE_FLAG_D_SEP "")     # , or empty
set(CMAKE_LIBRARY_PATH_FLAG "-L-L")
set(CMAKE_LIBRARY_PATH_TERMINATOR "")  # for the Digital Mars D compiler the link paths have to be terminated with a "/"
set(CMAKE_LINK_LIBRARY_FLAG "-L-l")

set(CMAKE_D_COMPILE_OPTIONS_PIC "-fPIC")

set(CMAKE_LINK_LIBRARY_SUFFIX "")
set(CMAKE_STATIC_LIBRARY_PREFIX "lib")
set(CMAKE_STATIC_LIBRARY_SUFFIX ".a")
set(CMAKE_SHARED_LIBRARY_PREFIX "lib")          # lib
set(CMAKE_SHARED_LIBRARY_SUFFIX ".so")          # .so
set(CMAKE_EXECUTABLE_SUFFIX "")          # .exe
set(CMAKE_DL_LIBS "dl")

set(CMAKE_FIND_LIBRARY_PREFIXES "lib")
set(CMAKE_FIND_LIBRARY_SUFFIXES ".so" ".a")

# set(CMAKE_D_STDLIBS "-L-lphobos2 -L-lpthread -L-lm -defaultlib=libphobos2.so")

# set(CMAKE_D_FLAGS_INIT "-version=${CMAKE_BUILD_TYPE}Build ${DSTDLIB_FLAGS} ${DSTDLIB_TYPE} -I$ENV{D_PATH}/include -I$ENV{D_PATH}/import -I${CMAKE_PROJECT_SOURCE_DIR}")
set(CMAKE_D_FLAGS_INIT "")

set(CMAKE_D_LINK_FLAGS "")
set(CMAKE_D_FLAGS_DEBUG_INIT "-g -debug -L--export-dynamic ${DDOC_FLAGS}")
set(CMAKE_D_FLAGS_MINSIZEREL_INIT "-O -L-s ${DDOC_FLAGS}")
set(CMAKE_D_FLAGS_RELEASE_INIT "-O ${DDOC_FLAGS}")
set(CMAKE_D_FLAGS_RELWITHDEBINFO_INIT "-O -g -L--export-dynamic ${DDOC_FLAGS}")
# set(CMAKE_D_CREATE_PREPROCESSED_SOURCE "<CMAKE_D_COMPILER> <FLAGS> -E <SOURCE> > <PREPROCESSED_SOURCE>")
set(CMAKE_D_CREATE_ASSEMBLY_SOURCE "<CMAKE_D_COMPILER> <FLAGS> -S <SOURCE> -of<ASSEMBLY_SOURCE>")
# set(CMAKE_INCLUDE_SYSTEM_FLAG_D "-isystem ")
set(CMAKE_D_VERSION_FLAG "-version=")
set(CMAKE_DEPFILE_FLAGS_D "-makedeps=<DEP_FILE>")
set(CMAKE_LINKER_FLAG_PREFIX "-L=")
