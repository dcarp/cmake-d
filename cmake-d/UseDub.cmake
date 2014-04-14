# This modules add functions for downloading and building dub dependencies.
# This code sets the following variables and functions:
#
# DUB_DIRECTORY = the full path to Dub pacakges
#
# DubProject_Add(<dub_package> [version]) 
#
#============================================================================
#  Copyright (c) 2014 Dragos Carp <dragos.carp@gmail.com>
#
# All rights reserved.
#
# See LICENSE for details.
#

set(DUB_DIRECTORY ${CMAKE_BINARY_DIR}/UseDub CACHE PATH "Dub packages direcotry")

set(DUB_REGISTRY "http://code.dlang.org/packages")
file(MAKE_DIRECTORY ${DUB_DIRECTORY}/CMakeTmp)

if(NOT CMAKE_D_COMPILER)
	message(FATAL_ERROR "UseDub needs a D compiler or use it in a D project.")
endif(NOT CMAKE_D_COMPILER)

#compile json parsers
if(NOT EXISTS ${DUB_DIRECTORY}/CMakeTmp/DubUrl OR 1)
	find_file(DUB_GET_PACKAGE_URL_D_SRC "DubUrl.d"
		PATHS ${CMAKE_ROOT}/Modules ${CMAKE_MODULE_PATH} NO_DEFAULT_PATH
		PATH_SUFFIXES "UseDub")
	find_file(SEMVER_SRC "semver.d"
		PATHS ${CMAKE_ROOT}/Modules ${CMAKE_MODULE_PATH} NO_DEFAULT_PATH
		PATH_SUFFIXES "UseDub")
	execute_process(COMMAND ${CMAKE_D_COMPILER} ${DUB_GET_PACKAGE_URL_D_SRC} ${SEMVER_SRC}
		WORKING_DIRECTORY ${DUB_DIRECTORY}/CMakeTmp)
	unset(DUB_GET_PACKAGE_URL_D_SRC CACHE)
endif(NOT EXISTS ${DUB_DIRECTORY}/CMakeTmp/DubUrl OR 1)
if(NOT EXISTS ${DUB_DIRECTORY}/CMakeTmp/DubToCMake OR 1)
	find_file(DUB_PACKAGE_TO_CMAKE_D_SRC "DubToCMake.d"
		PATHS ${CMAKE_ROOT}/Modules ${CMAKE_MODULE_PATH} NO_DEFAULT_PATH
		PATH_SUFFIXES "UseDub")
	execute_process(COMMAND ${CMAKE_D_COMPILER} ${DUB_PACKAGE_TO_CMAKE_D_SRC}
		WORKING_DIRECTORY ${DUB_DIRECTORY}/CMakeTmp)
	unset(DUB_PACKAGE_TO_CMAKE_D_SRC CACHE)
endif(NOT EXISTS ${DUB_DIRECTORY}/CMakeTmp/DubToCMake OR 1)

include(ExternalProject)

function(DubProject_Add name)
	if(NOT EXISTS ${DUB_DIRECTORY}/${name}.json)
		file(DOWNLOAD ${DUB_REGISTRY}/${name}.json ${DUB_DIRECTORY}/${name}.json)
	endif(NOT EXISTS ${DUB_DIRECTORY}/${name}.json)

	if(${ARGC} GREATER 1)
		execute_process(COMMAND ${DUB_DIRECTORY}/CMakeTmp/DubUrl -p ${name}.json -t ${ARGN}
			WORKING_DIRECTORY ${DUB_DIRECTORY})
	else(${ARGC} GREATER 1)
		execute_process(COMMAND ${DUB_DIRECTORY}/CMakeTmp/DubUrl -p ${name}.json
			WORKING_DIRECTORY ${DUB_DIRECTORY})
	endif(${ARGC} GREATER 1)

	include(${DUB_DIRECTORY}/${name}.cmake)

	ExternalProject_Add(${name}
		DOWNLOAD_DIR ${DUB_DIRECTORY}/${name}
		URL ${DUB_PACKAGE_URL}
		PATCH_COMMAND ${DUB_DIRECTORY}/CMakeTmp/DubToCMake -p package.json
		CMAKE_CACHE_ARGS -DCMAKE_MODULE_PATH:PATH=${CMAKE_MODULE_PATH})
endfunction()
