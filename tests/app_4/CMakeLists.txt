# This is a D app that links a C library.
#
# The linker preference of D is higher than C (or CXX), so after
# the objects are created, the D toolchain will drive linking.
#
add_executable(app_4 app_4.d)
include_directories(app_4 ${PROJECT_SOURCE_DIR})
add_test(app_4 app_4)
target_link_libraries(app_4 lib_2)
