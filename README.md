[![Build Status](https://github.com/dcarp/cmake-d/workflows/CI/badge.svg)](https://github.com/dcarp/cmake-d/actions?workflow=CI)

cmake-d
=======

CMake for D2 *improved*

Usage
-----

1. Download and extract https://github.com/dcarp/cmake-d/archive/master.zip to a local directory \<local-dir\> (you can use a git submodule if you want)
2. Create a D CMake Project: project(project-name D)
3. Run cmake as usual specifing the cmake-d path. To cache it, don't forget to specify the *:PATH* variable type.<br/>
```
cmake -DCMAKE_MODULE_PATH:PATH=<local-dir>/cmake-d <path-to-source>
```

*Tip: you can add before declaring the project `set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake-d/cmake-d)` (the path to the folder with all cmake files) in order to use the normal CMake command.*

Known issues
------------

This project is just a set of CMake files. It cannot do as much as a CMake binary patch. By example, regeneration of file acording a dependency file is hard coded in the Makefile backend; so when you edit a file and rebuild with this backend, it will build only the file you edited, leading to some deeper issues.

*Workaround:* use Ninja backend.
