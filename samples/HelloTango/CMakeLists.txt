#################################
# Preamble
##############

# where to look first for cmake modules, before ${CMAKE_ROOT}/Modules/ 
# is checked
set(CMAKE_MODULE_PATH
	${CMAKE_SOURCE_DIR}/cmake/Modules
)

# Using Tango
set(CMAKE_D_USE_TANGO True)

# check for DDoc usage
include(UseDDoc)

#################################
# Project
##############

# The name of our project is "HELLO".  CMakeLists files in this project can
# refer to the root source directory of the project as ${HELLO_SOURCE_DIR} and
# to the root binary directory of the project as ${HELLO_BINARY_DIR}.
PROJECT (HELLO D)

# Recurse into the "Hello" and "Demo" subdirectories.  This does not actually
# cause another cmake executable to run.  The same process will walk through
# the project's entire directory structure.
ADD_SUBDIRECTORY (Hello)
ADD_SUBDIRECTORY (Demo)
