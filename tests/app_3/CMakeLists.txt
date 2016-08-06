add_executable(app_3 app_3.d)
include_directories(app_3 ${PROJECT_SOURCE_DIR})
add_test(app_3 app_3)
target_link_libraries(app_3 lib_1)
