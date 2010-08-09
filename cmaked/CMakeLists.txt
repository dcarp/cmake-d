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
CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
PROJECT (cmaked NONE)

# note do not install FindGTK2.cmake.   it is not required to install it 
# to build the  samples, and can break apps that use other FindGTK2 modules.
SET (MOD_SRCS
	CMakeDCompiler.cmake.in        
	CMakeDCompilerId.d.in        
	CMakeDInformation.cmake        
	CMakeDCompilerABI.d        
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
