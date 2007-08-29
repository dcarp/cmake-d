#################################
# Preamble
##############

# where to look first for cmake modules, before ${CMAKE_ROOT}/Modules/ 
# is checked
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)

# Using Phobos OR Tango (can be specified from cmake command line)
if (NOT CMAKE_D_USE_PHOBOS AND NOT CMAKE_D_USE_TANGO)
	# default to phobos
	message(STATUS "This application can be built with either Phobos or Tango!")
	message(STATUS "You did not specify a standard library -- defaulting to Phobos.")
	message(STATUS "If you wish to use Tango add -DCMAKE_D_USE_TANGO=True to cmake command line.")
	set(CMAKE_D_USE_PHOBOS True)
endif (NOT CMAKE_D_USE_PHOBOS AND NOT CMAKE_D_USE_TANGO)

# check for DDoc usage
include(UseDDoc)

#################################
# Project
##############

project(FullSkeleton D)

#################################
# Defines
##############

# global needed variables
set(APPLICATION_NAME ${PROJECT_NAME})
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "1")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(APPLICATION_VERSION "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}")

#################################
# Configure Includes / Settings
##############

# set default build type to release
if (NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Release")
endif (NOT CMAKE_BUILD_TYPE)

# add definitions
include(DefineProjectDefaults)
include(DefineProjectOptions)
include(DefineCompilerFlags)
include(DefineInstallationPaths)

# add macros
include(MacroAddPlugin)
include(MacroEnsureOutOfSourceBuild)
include(ConfigureChecks.cmake)

# config.d
configure_file(config.d.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.d)

#################################
# Sub-directories
##############

subdirs(libraryA libraryB programClient programServer)

#################################
# Information
##############

message(STATUS "Installation Variables:
   Build Type             (CMAKE_BUILD_TYPE):       ${CMAKE_BUILD_TYPE}
   Install Prefix         (CMAKE_INSTALL_PREFIX):   ${CMAKE_INSTALL_PREFIX}
   Data Dir               (DATA_INSTALL_DIR):       ${DATA_INSTALL_DIR}
   Lib Dir                (LIB_INSTALL_DIR):        ${LIB_INSTALL_DIR}
   Plugin Dir             (PLUGIN_INSTALL_DIR):     ${PLUGIN_INSTALL_DIR}
   Config Dir             (SYSCONF_INSTALL_DIR):    ${SYSCONF_INSTALL_DIR}
   Build Client           (BUILD_CLIENT):           ${BUILD_CLIENT}
   Build Server           (BUILD_SERVER):           ${BUILD_SERVER}
   Build X11 Renderer     (BUILD_RENDERER_X11):     ${BUILD_RENDERER_X11}
   Build Windows Renderer (BUILD_RENDERER_WIN):     ${BUILD_RENDERER_WIN}
   Build Documentation    (CMAKE_D_BUILD_DOCS):     ${CMAKE_D_BUILD_DOCS}
   DDoc Files             (CMAKE_D_DDOC_FILES):     ${CMAKE_D_DDOC_FILES}"
)

#################################
# Packing
##############

include(InstallRequiredSystemLibraries)
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${PROJECT_NAME}")
set(CPACK_PACKAGE_VENDOR "${PROJECT_NAME}")
set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/COPYING")
set(CPACK_PACKAGE_FILE_NAME "${PROJECT_NAME}-${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}-linux-i686")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "${PROJECT_NAME}-${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}")
set(CPACK_GENERATOR "TGZ;TBZ2;ZIP")
set(CPACK_SOURCE_GENERATOR "TGZ;TBZ2")
set(CPACK_SOURCE_IGNORE_FILES "\\\\.svn/;/debug/;/optimized/;/documentation/;[a-z]*\\\\.kdev*;[a-z]*\\\\.tag;[a-z]*\\\\.pyc")
if (WIN32 AND NOT UNIX)
	# There is a bug in NSI that does not handle full unix paths properly. Make
	# sure there is at least one set of four (4) backlasshes.
	SET(CPACK_PACKAGE_ICON "${CMake_SOURCE_DIR}/Utilities/Release\\\\InstallIcon.bmp")
	SET(CPACK_NSIS_INSTALLED_ICON_NAME "bin\\\\MyExecutable.exe")
	SET(CPACK_NSIS_DISPLAY_NAME "${CPACK_PACKAGE_INSTALL_DIRECTORY} My Famous Project")
	SET(CPACK_NSIS_HELP_LINK "http:\\\\\\\\www.my-project-home-page.org")
	SET(CPACK_NSIS_URL_INFO_ABOUT "http:\\\\\\\\www.my-personal-home-page.com")
	SET(CPACK_NSIS_CONTACT "me@my-personal-home-page.com")
	SET(CPACK_NSIS_MODIFY_PATH ON)
else (WIN32 AND NOT UNIX)
	set(CPACK_STRIP_FILES "${PROJECT_NAME}/${PROJECT_NAME}")
	set(CPACK_SOURCE_STRIP_FILES "")
endif (WIN32 AND NOT UNIX)
set(CPACK_PACKAGE_EXECUTABLES "${PROJECT_NAME}" "${PROJECT_NAME}")
include(CPack)
