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

if(NOT DUB_DIRECTORY)
	set(DUB_DIRECTORY ${CMAKE_BINARY_DIR}/UseDub CACHE PATH "Dub packages directory")
endif()

set(DUB_REGISTRY "https://code.dlang.org/packages")
file(MAKE_DIRECTORY ${DUB_DIRECTORY}/CMakeTmp)

if(NOT CMAKE_D_COMPILER)
	message(FATAL_ERROR "UseDub needs a D compiler or use it in a D project.")
endif()

#compile json parsers
if(NOT EXISTS ${DUB_DIRECTORY}/CMakeTmp/DubUrl)
	find_file(DUB_GET_PACKAGE_URL_D_SRC "DubUrl.d"
		PATHS ${CMAKE_ROOT}/Modules ${CMAKE_MODULE_PATH} NO_DEFAULT_PATH
		PATH_SUFFIXES "UseDub")
	find_file(SEMVER_SRC "semver.d"
		PATHS ${CMAKE_ROOT}/Modules ${CMAKE_MODULE_PATH} NO_DEFAULT_PATH
		PATH_SUFFIXES "UseDub")
	get_filename_component(SEMVER_PATH ${SEMVER_SRC} PATH)
	execute_process(COMMAND ${CMAKE_D_COMPILER} -I${SEMVER_PATH} ${DUB_GET_PACKAGE_URL_D_SRC} ${SEMVER_SRC}
			${CMAKE_D_DASH_O}DubUrl WORKING_DIRECTORY ${DUB_DIRECTORY}/CMakeTmp)
	unset(DUB_GET_PACKAGE_URL_D_SRC CACHE)
endif()
if(NOT EXISTS ${DUB_DIRECTORY}/CMakeTmp/DubToCMake)
	find_file(DUB_PACKAGE_TO_CMAKE_D_SRC "DubToCMake.d"
		PATHS ${CMAKE_ROOT}/Modules ${CMAKE_MODULE_PATH} NO_DEFAULT_PATH
		PATH_SUFFIXES "UseDub")
	execute_process(COMMAND ${CMAKE_D_COMPILER} ${DUB_PACKAGE_TO_CMAKE_D_SRC} ${CMAKE_D_DASH_O}DubToCMake
		WORKING_DIRECTORY ${DUB_DIRECTORY}/CMakeTmp)
	unset(DUB_PACKAGE_TO_CMAKE_D_SRC CACHE)
endif()

include(FetchContent)

function(DubProject_Add name_full)
	string(FIND "${name_full}" ":" subpackage)

	if(subpackage EQUAL -1)
		set(name "${name_full}")
	else()
		string(REPLACE ":" ";" name_split ${name_full})

		list(GET name_split 0 name)
		list(GET name_split 1 subpackage)
	endif()

	if(NOT EXISTS ${DUB_DIRECTORY}/${name}.json)
		file(DOWNLOAD ${DUB_REGISTRY}/${name}.json ${DUB_DIRECTORY}/${name}.json STATUS status)
		list(GET status 0 statusCode)

		if(NOT statusCode EQUAL 0)
			file(REMOVE ${DUB_DIRECTORY}/${name}.json)
			message(FATAL_ERROR "Failed to download ${DUB_REGISTRY}/${name}.json")
		endif()
	endif()

	if(${ARGC} GREATER 1)
		execute_process(COMMAND ${DUB_DIRECTORY}/CMakeTmp/DubUrl -p ${name}.json -r ${DUB_REGISTRY} -t ${ARGV1}
			WORKING_DIRECTORY ${DUB_DIRECTORY})
	else()
		execute_process(COMMAND ${DUB_DIRECTORY}/CMakeTmp/DubUrl -p ${name}.json -r ${DUB_REGISTRY}
			WORKING_DIRECTORY ${DUB_DIRECTORY})
	endif()

	include(${DUB_DIRECTORY}/${name}.cmake)

	if(${ARGC} GREATER 2)
		FetchContent_Declare(
				${name}_proj
				URL ${DUB_PACKAGE_URL}
				PATCH_COMMAND ${DUB_DIRECTORY}/CMakeTmp/DubToCMake -c ${ARGV2} -s ${name_full} -p ${name}
		)
	else()
		FetchContent_Declare(
				${name}_proj
				URL ${DUB_PACKAGE_URL}
				PATCH_COMMAND ${DUB_DIRECTORY}/CMakeTmp/DubToCMake -s ${name_full} -p ${name}
		)
	endif()
	FetchContent_MakeAvailable(${name}_proj)

endfunction()
