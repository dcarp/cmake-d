# This is a D app that links a C library.
#
# The linker preference of D is higher than C (or CXX), so after
# the objects are created, the D toolchain will drive linking.
#
ADD_EXECUTABLE ( app_4 app_4.d )
INCLUDE_DIRECTORIES( app_4 ${PROJECT_SOURCE_DIR} )
TARGET_LINK_LIBRARIES( app_4 lib_2 )
ADD_TEST( app_4 app_4 )
