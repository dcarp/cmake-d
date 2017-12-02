# Adding D unittests
#
#  Copyright (c) 2010 Jens Mueller <jens.k.mueller@gmx.de>
#
# All rights reserved.
#
# See LICENSE for details.
#

macro(target_add_unittests _target _sourceFiles)
    set(_testtarget "test_${_target}")

    add_executable(${_testtarget} ${_sourceFiles})
    add_dependencies(${_testtarget} ${_target})
    target_compile_options(flow-core PRIVATE "-unittest")
    set_target_properties(${_testtarget} PROPERTIES LINK_FLAGS "-main")
    
    get_target_property(include_dirs ${_target} INCLUDE_DIRECTORIES)
    foreach(include_dir ${include_dirs})
        if(include_dir)
            target_include_directories(${_testtarget} PRIVATE "${include_dir}")
        endif()
    endforeach()

    get_target_property(libs ${_target} LINK_LIBRARIES)
    foreach(lib ${libs})
        if(lib)
            target_link_libraries(${_testtarget} ${lib})
        endif()
    endforeach()

    add_test(NAME ${_testtarget}
        COMMAND "$<TARGET_FILE:test_${_target}>")
    set_tests_properties(${_testtarget} PROPERTIES ENVIRONMENT "LD_LIBRARY_PATH=${CMAKE_CURRENT_SOURCE_DIR}/${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
endmacro()
