cmaked2
=======

cmake for D2

Usage
-----

1. Download and extract https://github.com/dcarp/cmaked2/archive/master.zip to a local directory \<cmaked2-path\>
2. Create a D CMake Project: project(project-name D)
3. Run cmake as usual specifing the cmaked2 path. To cache it, don't forget to specify the variable type (:PATH).<br/>
```
cmake -DCMAKE_MODULE_PATH:PATH=<cmaked2-path> <path-to-source>
```
