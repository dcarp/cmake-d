# This is a D app that links a C object.
#
# The linker preference of D is higher than C (or CXX), so after
# the objects are created, the D toolchain will drive linking.
#
ADD_EXECUTABLE ( app_5 app_5.d cfunc.c )
ADD_TEST( app_5 app_5 )
