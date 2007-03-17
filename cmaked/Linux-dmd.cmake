#
# CMakeD - CMake module for D Language
#
# Copyright (c) 2007, Selman Ulug <selman.ulug@gmail.com>
# All rights reserved.
#
# See Copyright.txt for details.
#
# Modified from CMake 2.6.5 gcc.cmake
# See http://www.cmake.org/HTML/Copyright.html for details
#

SET (CMAKE_D_FLAGS_INIT "")
SET (CMAKE_D_FLAGS_DEBUG_INIT "-g")
#  SET (CMAKE_D_FLAGS_MINSIZEREL_INIT "-Os")
SET (CMAKE_D_FLAGS_RELEASE_INIT "-O -release -inline")
SET (CMAKE_D_FLAGS_RELWITHDEBINFO_INIT "-O -g")
#  SET (CMAKE_D_CREATE_PREPROCESSED_SOURCE "<CMAKE_D_COMPILER> <FLAGS> -E <SOURCE> > <PREPROCESSED_SOURCE>")
SET (CMAKE_D_CREATE_ASSEMBLY_SOURCE "<CMAKE_D_COMPILER> <FLAGS> -S <SOURCE> -o <ASSEMBLY_SOURCE>")
#  SET (CMAKE_INCLUDE_SYSTEM_FLAG_D "-isystem ")
