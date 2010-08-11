# - pkg-config variable module for CMake
#
# Defines the following macros:
#
# PKGCONFIG_VAR(package varname outputvar)
#

include(UsePkgConfig REQUIRED)

MACRO(PKGCONFIG_VAR _package _varname _outputvar)
  # reset the variables at the beginning
  SET(${_outputvar})
  
  # if pkg-config has been found
  IF(PKGCONFIG_EXECUTABLE)
    EXEC_PROGRAM(${PKGCONFIG_EXECUTABLE} ARGS ${_package} --exists RETURN_VALUE _return_VALUE OUTPUT_VARIABLE _pkgconfigDevNull )
    
    # and if the package of interest also exists for pkg-config, then get the information
    IF(NOT _return_VALUE)
      EXEC_PROGRAM(${PKGCONFIG_EXECUTABLE} ARGS ${_package} --variable=${_varname} OUTPUT_VARIABLE ${_outputvar} )
    ENDIF(NOT _return_VALUE)
  ENDIF(PKGCONFIG_EXECUTABLE)
ENDMACRO(PKGCONFIG_VAR _package _varname _outputvar)

