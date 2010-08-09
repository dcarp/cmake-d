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
# Modified from CMake 2.6.5 CMakeTestCCompiler.cmake
# See http://www.cmake.org/HTML/Copyright.html for details
#

INCLUDE(CMakeTestCompilerCommon)

# This file is used by EnableLanguage in cmGlobalGenerator to
# determine that that selected D compiler can actually compile
# and link the most basic of programs.   If not, a fatal error
# is set and cmake stops processing commands and will not generate
# any makefiles or projects.
IF(NOT CMAKE_D_COMPILER_WORKS)
  PrintTestCompilerStatus("D" "")
  FILE(WRITE ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/testDCompiler.d
    "int main(char[][] args)\n"
    "{return args.sizeof-1;}\n")
  TRY_COMPILE(CMAKE_D_COMPILER_WORKS ${CMAKE_BINARY_DIR}
    ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/testDCompiler.d
    OUTPUT_VARIABLE OUTPUT)
  SET(D_TEST_WAS_RUN 1)
ENDIF(NOT CMAKE_D_COMPILER_WORKS)

IF(NOT CMAKE_D_COMPILER_WORKS)
  PrintTestCompilerStatus("D" " -- broken")
  message(STATUS "To force a specific D compiler set the DC environment variable")
  message(STATUS "    ie - export DC=\"/usr/bin/dmd\"")
  FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
    "Determining if the D compiler works failed with "
    "the following output:\n${OUTPUT}\n\n")
  # if the compiler is broken make sure to remove the platform file
  # since Windows-cl configures both c/cxx files both need to be removed
  # when c or c++ fails
  FILE(REMOVE ${CMAKE_PLATFORM_ROOT_BIN}/CMakeDPlatform.cmake )
  MESSAGE(FATAL_ERROR "The D compiler \"${CMAKE_D_COMPILER}\" "
    "is not able to compile a simple test program.\nIt fails "
    "with the following output:\n ${OUTPUT}\n\n"
    "CMake will not be able to correctly generate this project.")
ELSE(NOT CMAKE_D_COMPILER_WORKS)
  IF(D_TEST_WAS_RUN)
    MESSAGE(STATUS "Check for working D compiler: ${CMAKE_D_COMPILER} -- works")
    FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
      "Determining if the D compiler works passed with "
      "the following output:\n${OUTPUT}\n\n")
  ENDIF(D_TEST_WAS_RUN)
  SET(CMAKE_D_COMPILER_WORKS 1 CACHE INTERNAL "")

  IF(CMAKE_D_COMPILER_FORCED)
    # The compiler configuration was forced by the user.
    # Assume the user has configured all compiler information.
  ELSE(CMAKE_D_COMPILER_FORCED)
    # Try to identify the ABI and configure it into CMakeDCompiler.cmake
    INCLUDE(${CMAKE_ROOT}/Modules/CMakeDetermineCompilerABI.cmake)
    CMAKE_DETERMINE_COMPILER_ABI(D ${CMAKE_ROOT}/Modules/CMakeDCompilerABI.d)
    CONFIGURE_FILE(
      ${CMAKE_ROOT}/Modules/CMakeDCompiler.cmake.in
      ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeDCompiler.cmake
      @ONLY IMMEDIATE # IMMEDIATE must be here for compatibility mode <= 2.0
      )
    INCLUDE(${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeDCompiler.cmake)
  ENDIF(CMAKE_D_COMPILER_FORCED)
ENDIF(NOT CMAKE_D_COMPILER_WORKS)

