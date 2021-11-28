# Dependency tracking for D
#
#  Copyright (c) 2010 Jens Mueller <jens.k.mueller@gmx.de>
#
# All rights reserved.
#
# See LICENSE for details.
#

set(cmake_d_dir ${CMAKE_CURRENT_LIST_DIR})

function(resolve_dependencies target)
  get_target_property(d_source_files ${target} SOURCES)

  # extract D source files from arguments
  #message("D files in arguments: ${d_source_files}")

  foreach(full_file IN LISTS d_source_files)
    file(RELATIVE_PATH file "${CMAKE_CURRENT_SOURCE_DIR}" "${full_file}")
    set(source_file "${CMAKE_CURRENT_SOURCE_DIR}/${file}")
    set(deps_dir "${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/UseDDeps/")
    set(dependency_file "${deps_dir}${file}.dep")
    get_filename_component(deps_source_dir "${dependency_file}" DIRECTORY)
    file(MAKE_DIRECTORY "${deps_source_dir}")
    set(dependency_files ${dependency_files} ${dependency_file})

    add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/your_gen_file.txt"
            COMMAND /bin/date > "${CMAKE_BINARY_DIR}/your_gen_file.txt"
            COMMAND /bin/echo "RUNNING COMMAND")

    set_source_files_properties("${full_file}" PROPERTIES COMPILE_FLAGS "-deps=${dependency_file}" OBJECT_DEPENDS "${dependency_file}")
  endforeach()
endfunction()
