[![Build Status](https://github.com/dcarp/cmake-d/workflows/CI/badge.svg)](https://github.com/dcarp/cmake-d/actions?workflow=CI)

cmake-d
=======

CMake for D2

Usage
-----

1. Download and extract https://github.com/dcarp/cmake-d/archive/master.zip to a local directory \<local-dir\>
2. Create a D CMake Project: project(project-name D)
3. Run cmake as usual specifing the cmake-d path. To cache it, don't forget to specify the *:PATH* variable type.<br/>
```
cmake -DCMAKE_MODULE_PATH:PATH=<local-dir>/cmake-d <path-to-source>
```
