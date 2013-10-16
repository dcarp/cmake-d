#!/bin/bash
#
# I don't like this setup.  Ideas welcome.
#
# This script creates a build directory as a peer of cmaked2,
# and builds the tests there.
#
cd ../..
rm -rf cmake-d-test-build
mkdir -p cmake-d-test-build
cd cmake-d-test-build
mkdir -p release
cd release
# Do a release build
cmake ../../cmake-d/tests
make
make test
cd ..

# Do a debug build
mkdir -p debug
cd debug
cmake -DCMAKE_VERBOSE_MAKEFILE=1 -DCMAKE_BUILD_TYPE=debug ../../cmake-d/tests
make
make test
cd ../..

