#################################

if (BUILD_CLIENT)

#################################
# Project
##############

project(ProgramClient D)

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
	${RENDERER_DEFINITIONS}
)

#################################
# Source Files
##############

add_executable(client
	ProgramClient.d
	ProgramClientApp.d
	ProgramClientMain.d
)

#################################
# Linking
##############

target_link_libraries(client
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

install(TARGETS client
	RUNTIME DESTINATION bin
)

#################################

endif (BUILD_CLIENT)

