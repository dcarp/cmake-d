#################################
# Project
##############

project(libraryB D)

#################################
# Dependencies
##############

# x11 plugin
if (BUILD_RENDERER_X11)
	find_package(X11 REQUIRED)	
	set(RENDERER_X11_SOURCES 
		"render/RendererX11.d"
	)
	set(RENDERER_DEFINITIONS "${RENDERER_DEFINITIONS} ${CMAKE_D_VERSION_FLAG}RendererX11" CACHE BOOLEAN TRUE FORCE)
endif (BUILD_RENDERER_X11)

# windows renderer
if (BUILD_RENDERER_WIN)
	set(RENDERER_WIN_SOURCES 
		"render/RendererWindows.d"
	)
	set(RENDERER_DEFINITIONS "${RENDERER_DEFINITIONS} ${CMAKE_D_VERSION_FLAG}RendererWin" CACHE BOOLEAN TRUE FORCE)
endif (BUILD_RENDERER_WIN)

#################################
# Compiler Switches
##############

include_directories(
	${CMAKE_BINARY_DIR}
	${CMAKE_SOURCE_DIR}
	${X11_INCLUDE_DIR}
)

link_directories(
)

add_definitions(
	${RENDERER_DEFINITIONS}
)

#################################
# Source Files
##############

add_library(B STATIC
	LibraryB.d
	render/Renderer.d
	${RENDERER_X11_SOURCES}
	${RENDERER_WIN_SOURCES}
)

#################################
# Linking
##############

target_link_libraries(B
	A
	${X11_LIBRARIES}
)

#################################
# Install Files
##############

file(GLOB headers "${CMAKE_CURRENT_SOURCE_DIR}/*.d")
install(
	FILES
		${headers}
	DESTINATION
		include/FullSkeleton/B
)

