#!/bin/bash
#
# I don't like this setup.  Ideas welcome.
cd ../..
rm -rf cmaked_test_build
mkdir -p cmaked_test_build
cd cmaked_test_build
mkdir -p release
cd release
# Do a release build
cmake ../../cmaked2/tests
make
make test
cd ..

# Do a debug build
mkdir -p debug
cd debug
cmake -DCMAKE_VERBOSE_MAKEFILE=1 -DCMAKE_BUILD_TYPE=debug ../../cmaked2/tests
make
make test
cd ../..

