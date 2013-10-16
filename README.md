cmake-d
=======

CMake for D2

Usage
-----

1. Download and extract https://github.com/dcarp/cmake-d/archive/master.zip to a local directory \<cmake-d-dir\>
2. Create a D CMake Project: project(project-name D)
3. Run cmake as usual specifing the cmake-d path. To cache it, don't forget to specify the *:PATH* variable type.<br/>
```
cmake -DCMAKE_MODULE_PATH:PATH=<cmake-d-dir> <path-to-source>
```
