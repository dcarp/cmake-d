#################################
# Project
##############

project(libraryA D)

#################################
# Dependencies
##############

# INotify
if (HAVE_INOTIFY_INIT)
	set(INOTIFY_SOURCES "io/INotify.d")
	set(INOTIFY_DEFINITIONS "${INOTIFY_DEFINITIONS} ${CMAKE_D_VERSION_FLAG}INotify" CACHE BOOLEAN TRUE FORCE)
endif (HAVE_INOTIFY_INIT)

#################################
# Compiler Switches
##############

INCLUDE_DIRECTORIES(
	${CMAKE_BINARY_DIR}
	${CMAKE_SOURCE_DIR}
)

link_directories(
)

add_definitions(
	${INOTIFY_DEFINITIONS}
)

#################################
# Source Files
##############

add_library(A STATIC
	core/Exception.d
	${INOTIFY_SOURCES}
	io/Output.d
        mixins/BladeParse.d
        mixins/HandyMixins.d
        mixins/HandyMixinHelpers.d
)

#################################
# Linking
##############

target_link_libraries(A
)

#################################
# Clean ddoc's
##############

set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${CMAKE_D_DDOC_CLEAN_FILES}")

#################################
# Install Files
##############

file(GLOB sources "${CMAKE_CURRENT_SOURCE_DIR}/*.d")
install(
	FILES
		${sources}
	DESTINATION
		include/FullSkeleton/A
)

