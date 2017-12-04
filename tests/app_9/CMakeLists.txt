cmake_minimum_required(VERSION 3.8)
project (test D)
include(UseDUnittest)

set(CMAKE_BUILD_TYPE DEBUG)

enable_testing()

# TODO
# how to rerun cmake if a new file is created
# I don't want to miss new unittests

# add all files
file(GLOB files RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "module*.d")
foreach(file IN LISTS files)
  add_unittests(${file})
endforeach()

add_library(foo ${files})
add_unittests_for_target(foo)
