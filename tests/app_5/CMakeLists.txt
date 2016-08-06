# This is a D app that links a C object.
#
# The linker preference of D is higher than C (or CXX), so after
# the objects are created, the D toolchain will drive linking.
#
add_executable(app_5 app_5.d cfunc.c)
add_test(app_5 app_5)
