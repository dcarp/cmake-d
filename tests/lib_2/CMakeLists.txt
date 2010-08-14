# This project is a C library
PROJECT( lib_2 C )
ADD_DEFINITIONS( ${GLOBAL_C_DEFS} )
ADD_LIBRARY( lib_2 STATIC lib_2.c )
