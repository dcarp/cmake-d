#################################

if (BUILD_SERVER)

#################################
# Project
##############

project(ProgramServer D)

#################################
# Dependencies
##############

#################################
# Compiler Switches
##############

include_directories(
	${CMAKE_BINARY_DIR}
	${CMAKE_SOURCE_DIR}
)

link_directories(
	${CMAKE_BINARY_DIR}/libraryA
	${CMAKE_BINARY_DIR}/libraryB
)

add_definitions(
)

#################################
# Source Files
##############

add_executable(server
	ProgramServerMain.d
)

#################################
# Linking
##############

target_link_libraries(server
	A
	B
)

#################################
# Install Files
##############

file(GLOB sources "${CMAKE_CURRENT_SOURCE_DIR}/*.d")
install(
	FILES
		${sources}
	DESTINATION
	include/FullSkeleton
)

install(TARGETS server
	RUNTIME DESTINATION bin
)

#################################

endif (BUILD_SERVER)

