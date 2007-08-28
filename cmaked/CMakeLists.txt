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

PROJECT (cmaked NONE)

SET (MOD_SRCS
	CMakeDCompiler.cmake.in        
	CMakeDInformation.cmake        
	CMakeTestDCompiler.cmake  
	CMakeDetermineDCompiler.cmake  
	FindGDCPath.cmake
	UseDDoc.cmake
)

SET (PLAT_SRCS
	Platform/Linux-dmd.cmake
	Platform/Linux-gdc.cmake 
	Platform/Windows-dmd.cmake              
	Platform/Windows-gdc.cmake
)

INSTALL (FILES ${MOD_SRCS} DESTINATION ${CMAKE_ROOT}/Modules)
INSTALL (FILES ${PLAT_SRCS} DESTINATION ${CMAKE_ROOT}/Modules/Platform)
