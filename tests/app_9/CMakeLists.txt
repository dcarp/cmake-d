include(UseDUnittest)

enable_testing()

# TODO
# how to rerun cmake if a new file is created
# I don't want to miss new unittests

# add all files
set(files "moduleA.d" "moduleB.d")
foreach(file IN LISTS files)
  add_unittests(${file})
endforeach()

add_library(app_9_targettest ${files})
add_unittests_for_target(app_9_targettest)
