#
# CMakeD - CMake module for D Language
#
# Copyright (c) 2007, Selman Ulug <selman.ulug@gmail.com>
#                     Tim Burrell <tim.burrell@gmail.com>
#
# All rights reserved.
#
# See Copyright.txt for details.
#
# Modified from CMake 2.6.5 CMakeDetermineCCompiler.cmake
# See http://www.cmake.org/HTML/Copyright.html for details
#

# determine the compiler to use for D programs
# NOTE, a generator may set CMAKE_D_COMPILER before
# loading this file to force a compiler.
# use environment variable DC first if defined by user, next use
# the cmake variable CMAKE_GENERATOR_D which can be defined by a generator
# as a default compiler

IF(NOT CMAKE_D_COMPILER)
  SET(CMAKE_D_COMPILER_INIT NOTFOUND)
  # prefer the environment variable DC
  IF($ENV{DC} MATCHES ".+")
    GET_FILENAME_COMPONENT(CMAKE_D_COMPILER_INIT $ENV{DC} PROGRAM PROGRAM_ARGS CMAKE_D_FLAGS_ENV_INIT)
    IF(CMAKE_D_FLAGS_ENV_INIT)
      SET(CMAKE_D_COMPILER_ARG1 "${CMAKE_D_FLAGS_ENV_INIT}" CACHE STRING "First argument to D compiler")
    ENDIF(CMAKE_D_FLAGS_ENV_INIT)
    IF(NOT EXISTS ${CMAKE_D_COMPILER_INIT})
      MESSAGE(FATAL_ERROR "Could not find compiler set in environment variable C:\n$ENV{DC}.")
    ENDIF(NOT EXISTS ${CMAKE_D_COMPILER_INIT})
  ENDIF($ENV{DC} MATCHES ".+")

  # next try prefer the compiler specified by the generator
  IF(CMAKE_GENERATOR_D)
    IF(NOT CMAKE_D_COMPILER_INIT)
      SET(CMAKE_D_COMPILER_INIT ${CMAKE_GENERATOR_D})
    ENDIF(NOT CMAKE_D_COMPILER_INIT)
  ENDIF(CMAKE_GENERATOR_D)

  # finally list compilers to try
  IF(CMAKE_D_COMPILER_INIT)
    SET(CMAKE_D_COMPILER_LIST ${CMAKE_D_COMPILER_INIT})
  ELSE(CMAKE_D_COMPILER_INIT)
    SET(CMAKE_D_COMPILER_LIST ${_CMAKE_TOOLCHAIN_PREFIX}gdc ${_CMAKE_TOOLCHAIN_PREFIX}dmd)
  ENDIF(CMAKE_D_COMPILER_INIT)

  # Find the compiler.
  IF (_CMAKE_USER_D_COMPILER_PATH)
  	FIND_PROGRAM(CMAKE_D_COMPILER NAMES ${CMAKE_D_COMPILER_LIST} PATHS ${_CMAKE_USER_D_COMPILER_PATH} DOC "D compiler" NO_DEFAULT_PATH)
  ENDIF (_CMAKE_USER_D_COMPILER_PATH)
  FIND_PROGRAM(CMAKE_D_COMPILER NAMES ${CMAKE_D_COMPILER_LIST} DOC "D compiler")

  IF(CMAKE_D_COMPILER_INIT AND NOT CMAKE_D_COMPILER)
    SET(CMAKE_D_COMPILER "${CMAKE_D_COMPILER_INIT}" CACHE FILEPATH "D compiler" FORCE)
  ENDIF(CMAKE_D_COMPILER_INIT AND NOT CMAKE_D_COMPILER)
ELSE (NOT CMAKE_D_COMPILER)

  # we only get here if CMAKE_D_COMPILER was specified using -D or a pre-made CMakeCache.txt
  # (e.g. via ctest) or set in CMAKE_TOOLCHAIN_FILE
  # if CMAKE_D_COMPILER is a list of length 2, use the first item as
  # CMAKE_D_COMPILER and the 2nd one as CMAKE_D_COMPILER_ARG1

  LIST(LENGTH CMAKE_D_COMPILER _CMAKE_D_COMPILER_LIST_LENGTH)
  IF("${_CMAKE_D_COMPILER_LIST_LENGTH}" EQUAL 2)
    LIST(GET CMAKE_D_COMPILER 1 CMAKE_D_COMPILER_ARG1)
    LIST(GET CMAKE_D_COMPILER 0 CMAKE_D_COMPILER)
  ENDIF("${_CMAKE_D_COMPILER_LIST_LENGTH}" EQUAL 2)

  # if a compiler was specified by the user but without path,
  # now try to find it with the full path
  # if it is found, force it into the cache,
  # if not, don't overwrite the setting (which was given by the user) with "NOTFOUND"
  # if the C compiler already had a path, reuse it for searching the CXX compiler
  GET_FILENAME_COMPONENT(_CMAKE_USER_D_COMPILER_PATH "${CMAKE_D_COMPILER}" PATH)
  IF(NOT _CMAKE_USER_D_COMPILER_PATH)
    FIND_PROGRAM(CMAKE_D_COMPILER_WITH_PATH NAMES ${CMAKE_D_COMPILER})
    MARK_AS_ADVANCED(CMAKE_D_COMPILER_WITH_PATH)
    IF(CMAKE_D_COMPILER_WITH_PATH)
      SET(CMAKE_D_COMPILER ${CMAKE_D_COMPILER_WITH_PATH} CACHE STRING "D compiler" FORCE)
    ENDIF(CMAKE_D_COMPILER_WITH_PATH)
  ENDIF(NOT _CMAKE_USER_D_COMPILER_PATH)
ENDIF(NOT CMAKE_D_COMPILER)
MARK_AS_ADVANCED(CMAKE_D_COMPILER)

IF (NOT _CMAKE_TOOLCHAIN_LOCATION)
  GET_FILENAME_COMPONENT(_CMAKE_TOOLCHAIN_LOCATION "${CMAKE_D_COMPILER}" PATH)
ENDIF (NOT _CMAKE_TOOLCHAIN_LOCATION)

# Build a small source file to identify the compiler.
IF(${CMAKE_GENERATOR} MATCHES "Visual Studio")
  SET(CMAKE_D_COMPILER_ID_RUN 1)
  SET(CMAKE_D_PLATFORM_ID "Windows")

  # TODO: Set the compiler id.  It is probably MSVC but
  # the user may be using an integrated Intel compiler.
  # SET(CMAKE_D_COMPILER_ID "MSVC")
ENDIF(${CMAKE_GENERATOR} MATCHES "Visual Studio")

IF(NOT CMAKE_D_COMPILER_ID_RUN)
  SET(CMAKE_D_COMPILER_ID_RUN 1)

  # Each entry in this list is a set of extra flags to try
  # adding to the compile line to see if it helps produce
  # a valid identification file.
  SET(CMAKE_D_COMPILER_ID_TEST_FLAGS
    # Try compiling to an object file only.
    "-c"
    )

  # Try to identify the compiler.
  SET(CMAKE_D_COMPILER_ID)
  FILE(READ ${CMAKE_ROOT}/Modules/CMakePlatformId.h.in
    CMAKE_D_COMPILER_ID_PLATFORM_CONTENT)
  INCLUDE(${CMAKE_ROOT}/Modules/CMakeDetermineCompilerId.cmake)
  CMAKE_DETERMINE_COMPILER_ID(D DFLAGS CMakeDCompilerId.d)

  # Set old compiler and platform id variables.
  IF("${CMAKE_D_COMPILER_ID}" MATCHES "GNU")
    SET(CMAKE_COMPILER_IS_GDC 1)
  ENDIF("${CMAKE_D_COMPILER_ID}" MATCHES "GNU")
  IF("${CMAKE_D_PLATFORM_ID}" MATCHES "MinGW")
    SET(CMAKE_COMPILER_IS_MINGW 1)
  ELSEIF("${CMAKE_D_PLATFORM_ID}" MATCHES "Cygwin")
    SET(CMAKE_COMPILER_IS_CYGWIN 1)
  ENDIF("${CMAKE_D_PLATFORM_ID}" MATCHES "MinGW")
ENDIF(NOT CMAKE_D_COMPILER_ID_RUN)




INCLUDE(CMakeFindBinUtils)
IF(MSVC_D_ARCHITECTURE_ID)
  SET(SET_MSVC_D_ARCHITECTURE_ID
    "SET(MSVC_D_ARCHITECTURE_ID ${MSVC_D_ARCHITECTURE_ID})")
ENDIF(MSVC_D_ARCHITECTURE_ID)
# configure variables set in this file for fast reload later on
CONFIGURE_FILE(${CMAKE_ROOT}/Modules/CMakeDCompiler.cmake.in
  "${CMAKE_PLATFORM_ROOT_BIN}/CMakeDCompiler.cmake"
  @ONLY IMMEDIATE # IMMEDIATE must be here for compatibility mode <= 2.0
  )
SET(CMAKE_D_COMPILER_ENV_VAR "DC")
