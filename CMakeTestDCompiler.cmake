# This file is used by EnableLanguage in cmGlobalGenerator to
# determine that that selected D compiler can actually compile
# and link the most basic of programs.   If not, a fatal error
# is set and cmake stops processing commands and will not generate
# any makefiles or projects.
IF(NOT CMAKE_D_COMPILER_WORKS)
  MESSAGE(STATUS "Check for working D compiler: ${CMAKE_D_COMPILER}")
  FILE(WRITE ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/testDCompiler.d
    "import std.stdio;\n"
    "int main(char[][] args)\n"
    "{ writefln(\"%s\", args[0]); return args.sizeof-1;}\n")
  TRY_COMPILE(CMAKE_D_COMPILER_WORKS ${CMAKE_BINARY_DIR} ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/testDCompiler.d
     OUTPUT_VARIABLE OUTPUT) 
  SET(C_TEST_WAS_RUN 1)
ENDIF(NOT CMAKE_D_COMPILER_WORKS)

IF(NOT CMAKE_D_COMPILER_WORKS)
  MESSAGE(STATUS "Check for working D compiler: ${CMAKE_D_COMPILER} -- broken")
  FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
    "Determining if the D compiler works failed with "
    "the following output:\n${OUTPUT}\n\n")
  MESSAGE(FATAL_ERROR "The D compiler \"${CMAKE_D_COMPILER}\" "
    "is not able to compile a simple test program.\nIt fails "
    "with the following output:\n ${OUTPUT}\n\n"
    "CMake will not be able to correctly generate this project.")
ELSE(NOT CMAKE_D_COMPILER_WORKS)
  IF(C_TEST_WAS_RUN)
    MESSAGE(STATUS "Check for working D compiler: ${CMAKE_D_COMPILER} -- works")
    FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
      "Determining if the D compiler works passed with "
      "the following output:\n${OUTPUT}\n\n") 
  ENDIF(C_TEST_WAS_RUN)
  SET(CMAKE_D_COMPILER_WORKS 1 CACHE INTERNAL "")
  # re-configure this file CMakeDCompiler.cmake so that it gets
  # the value for CMAKE_SIZEOF_VOID_P
  # configure variables set in this file for fast reload later on
  CONFIGURE_FILE(${CMAKE_ROOT}/Modules/CMakeDCompiler.cmake.in 
    ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeDCompiler.cmake IMMEDIATE)
ENDIF(NOT CMAKE_D_COMPILER_WORKS)
