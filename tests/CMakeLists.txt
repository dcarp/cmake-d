# Tell cmake our project only concerns the D language.
cmake_minimum_required(VERSION 2.8.1)

set(CMAKE_BUILD_TYPE Debug)

# We must explicitly indicate we're using the D language
# in the project declaration.  Listing other languages
# is fine.
project(CMAKE-D_TESTS C D)
set(GLOBAL_DMD_DEFS "-w")
set(GLOBAL_GCC_DEFS "-Wall -pedantic")

# Don't use add_definitions() with a mixed C + D project
# since that adds the same flags to both C and D builds.
# Also, the D linker preference is set to 40, which is
# higher than C++ (30) and C (10).  This causes CMAKE
# to use the D linker in mixed linking cases.
# Append our own definitions to the defaults.
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${GLOBAL_GCC_DEFS}")
set(CMAKE_D_FLAGS "${CMAKE_D_FLAGS} ${GLOBAL_DMD_DEFS}")

enable_testing()

# build libs first, then apps
add_subdirectory(lib_2)
add_subdirectory(lib_1)
add_subdirectory(app_1)
add_subdirectory(app_2)
add_subdirectory(app_3)
add_subdirectory(app_5)
add_subdirectory(app_4)
add_subdirectory(app_6)
add_subdirectory(app_7)
add_subdirectory(app_8)
add_subdirectory(app_9)
