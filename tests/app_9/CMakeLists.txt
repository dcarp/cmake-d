include(UseDUnittest)

# TODO
# how to rerun cmake if a new file is created
# I don't want to miss new unittests

# add all files
file(GLOB files RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.d")
foreach(file IN LISTS files)
	add_unittests(${file})
endforeach()

#add_unittests(moduleA.d)
#add_unittests(moduleB.d)
