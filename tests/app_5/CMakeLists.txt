# This is a D app that links a C object.
#
# The linker preference of D is higher than C (or CXX), so after
# the objects are created, the D toolchain will drive linking.
#
# TODO
# dirty fix
# we should make the CMAKE_D_COMPILER_ID work
IF("${CMAKE_BASE_NAME}" MATCHES "dmd")
	SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m32" )
ENDIF()
ADD_EXECUTABLE ( app_5 app_5.d cfunc.c )
ADD_TEST( app_5 app_5 )
