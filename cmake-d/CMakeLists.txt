#
# CMakeD - CMake module for D Language
#
# Copyright (c) 2013, Selman Ulug <selman.ulug@gmail.com>
#                     Tim Burrell <tim.burrell@gmail.com>
#                     Dragos Carp <dragos.carp@gmail.com>
#
# All rights reserved.
#
# See LICENSE for details.
#
cmake_minimum_required(VERSION 3.20)
project(cmake-d NONE)

set(MOD_SRCS
	CMakeDCompiler.cmake.in        
	CMakeDCompilerId.d.in        
	CMakeDInformation.cmake        
	CMakeDCompilerABI.d        
	CMakeTestDCompiler.cmake  
	CMakeDetermineDCompiler.cmake  
	FindGDCPath.cmake
	UseDDoc.cmake
		UseDDepsMakeWIP.cmake
	UseDub.cmake
	dependencies.cmake
	UseDUnittest.cmake
	FindPhobos.cmake
	CMakePlatformId.di.in
)

set(PLAT_SRCS
	Platform/Darwin-dmd.cmake
	Platform/Darwin-ldc2.cmake
	Platform/Linux-dmd.cmake
	Platform/Linux-gdc.cmake 
	Platform/Linux-ldc2.cmake 
	Platform/Windows-dmd.cmake              
	Platform/Windows-gdc.cmake
)

install(FILES ${MOD_SRCS} DESTINATION ${CMAKE_ROOT}/Modules)
install(FILES ${PLAT_SRCS} DESTINATION ${CMAKE_ROOT}/Modules/Platform)
