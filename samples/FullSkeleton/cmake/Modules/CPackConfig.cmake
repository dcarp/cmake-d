# This file will be configured to contain variables for CPack. These variables
# should be set in the CMake list file of the project before CPack module is
# included. Example variables are:
#   CPACK_GENERATOR                     - Generator used to create package
#   CPACK_INSTALL_CMAKE_PROJECTS        - For each project (path, name, component)
#   CPACK_CMAKE_GENERATOR               - CMake Generator used for the projects
#   CPACK_INSTALL_COMMANDS              - Extra commands to install components
#   CPACK_INSTALL_DIRECTORIES           - Extra directories to install
#   CPACK_PACKAGE_DESCRIPTION_FILE      - Description file for the package
#   CPACK_PACKAGE_DESCRIPTION_SUMMARY   - Summary of the package
#   CPACK_PACKAGE_EXECUTABLES           - List of pairs of executables and labels
#   CPACK_PACKAGE_FILE_NAME             - Name of the package generated
#   CPACK_PACKAGE_ICON                  - Icon used for the package
#   CPACK_PACKAGE_INSTALL_DIRECTORY     - Name of directory for the installer
#   CPACK_PACKAGE_NAME                  - Package project name
#   CPACK_PACKAGE_VENDOR                - Package project vendor
#   CPACK_PACKAGE_VERSION               - Package project version
#   CPACK_PACKAGE_VERSION_MAJOR         - Package project version (major)
#   CPACK_PACKAGE_VERSION_MINOR         - Package project version (minor)
#   CPACK_PACKAGE_VERSION_PATCH         - Package project version (patch)

# There are certain generator specific ones

# NSIS Generator:
#   CPACK_PACKAGE_INSTALL_REGISTRY_KEY  - Name of the registry key for the installer
#   CPACK_NSIS_EXTRA_UNINSTALL_COMMANDS - Extra commands used during uninstall
#   CPACK_NSIS_EXTRA_INSTALL_COMMANDS   - Extra commands used during install


SET(CPACK_CMAKE_GENERATOR "Unix Makefiles")
SET(CPACK_GENERATOR "TGZ;TBZ2;ZIP")
SET(CPACK_INSTALL_CMAKE_PROJECTS "/home/tim/projects/mmorlg.D/cmake/Modules;mmorlg;ALL;/")
SET(CPACK_MODULE_PATH "/home/tim/projects/mmorlg.D/cmake/Modules")
SET(CPACK_NSIS_DISPLAY_NAME "mmorlg 0.1.0")
SET(CPACK_OUTPUT_CONFIG_FILE "/home/tim/projects/mmorlg.D/cmake/Modules/CPackConfig.cmake")
SET(CPACK_PACKAGE_DESCRIPTION_FILE "/home/tim/projects/mmorlg.D/README")
SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "mmorlg")
SET(CPACK_PACKAGE_EXECUTABLES "mmorlg;mmorlg")
SET(CPACK_PACKAGE_FILE_NAME "mmorlg-0.1-linux-i686")
SET(CPACK_PACKAGE_INSTALL_DIRECTORY "mmorlg 0.1.0")
SET(CPACK_PACKAGE_INSTALL_REGISTRY_KEY "mmorlg 0.1.0")
SET(CPACK_PACKAGE_NAME "mmorlg")
SET(CPACK_PACKAGE_VENDOR "mmorlg")
SET(CPACK_PACKAGE_VERSION "0.1.0")
SET(CPACK_PACKAGE_VERSION_MAJOR "0")
SET(CPACK_PACKAGE_VERSION_MINOR "1")
SET(CPACK_PACKAGE_VERSION_PATCH "0")
SET(CPACK_RESOURCE_FILE_LICENSE "/home/tim/projects/mmorlg.D/COPYING")
SET(CPACK_RESOURCE_FILE_README "/usr/share/cmake/Templates/CPack.GenericDescription.txt")
SET(CPACK_RESOURCE_FILE_WELCOME "/usr/share/cmake/Templates/CPack.GenericWelcome.txt")
SET(CPACK_SOURCE_GENERATOR "TGZ;TBZ2")
SET(CPACK_SOURCE_IGNORE_FILES "\\.svn/;/debug/;/optimized/;/documentation/;[a-z]*\\.kdev*;[a-z]*\\.tag;[a-z]*\\.pyc")
SET(CPACK_SOURCE_OUTPUT_CONFIG_FILE "/home/tim/projects/mmorlg.D/cmake/Modules/CPackSourceConfig.cmake")
SET(CPACK_SOURCE_PACKAGE_FILE_NAME "mmorlg-0.1")
SET(CPACK_SOURCE_STRIP_FILES "")
SET(CPACK_STRIP_FILES "mmorlg/mmorlg")
SET(CPACK_SYSTEM_NAME "Linux")
SET(CPACK_TOPLEVEL_TAG "Linux")
