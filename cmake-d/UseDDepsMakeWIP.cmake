set(cmake_d_dir ${CMAKE_CURRENT_LIST_DIR})

function(depfile_from_file depfile file)
  file(RELATIVE_PATH file "${CMAKE_CURRENT_SOURCE_DIR}" "${full_file}")
  set(source_file "${CMAKE_CURRENT_SOURCE_DIR}/${file}")
  set(deps_dir "${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/UseDDeps/")
  set(${depfile} "${deps_dir}${file}.dep" PARENT_SCOPE)
endfunction()

function(resolve_dependencies target)
  get_target_property(d_source_files ${target} SOURCES)

  # extract D source files from arguments
  #message("D files in arguments: ${d_source_files}")

  foreach(full_file IN LISTS d_source_files)
    set(CMAKE_DEPENDS_USE_COMPILER true)
    depfile_from_file(dependency_file ${full_file})
    message("${dependency_file}")

    string(REPLACE "<DEPFILE>" "${dependency_file}" depflag "${CMAKE_DEPFILE_FLAGS_D}")
#    add_custom_command(DEPFILE "${dependency_file}" OUTPUT "${dependency_file}" DEPENDS "")
#    set_source_files_properties("${full_file}" PROPERTIES OBJECT_DEPENDS "${dependency_file}")
  endforeach()
endfunction()


macro(add_executable_with_dependencies _target)
  # extract D source files from arguments
  foreach(file ${ARGV})
    if(${file} MATCHES "\\.d$")
      list(APPEND d_source_files ${file})
    endif()
  endforeach()

  #message("D files in arguments: ${d_source_files}")

  foreach(file IN LISTS d_source_files)
    file(RELATIVE_PATH file "${CMAKE_CURRENT_SOURCE_DIR}" "${full_file}")
    set(source_file "${CMAKE_CURRENT_SOURCE_DIR}/${file}")
    set(deps_dir "${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/UseDDeps/")
    set(dependency_file "${deps_dir}${file}.dep")
    get_filename_component(deps_source_dir "${dependency_file}" DIRECTORY)
    set("${CMAKE_D_COMPILER} -o- -M")
  endforeach()

  add_executable(${ARGV} ${dependency_files})
endmacro()
