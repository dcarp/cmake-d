#!/bin/bash
#
# I don't like this setup.  Ideas welcome.
#
# This script creates a build directory as a peer of cmaked2,
# and builds the tests there.
#
CMAKE_DIR=`pwd`/../cmake-d
TEST_DIR=../../cmake-d-test-build
rm -rf $TEST_DIR
mkdir -p $TEST_DIR
cd $TEST_DIR
mkdir -p release
cd release
# Do a release build
cmake -DCMAKE_MODULE_PATH:PATH=$CMAKE_DIR ../../cmake-d/tests
make
make test
cd ..

# Do a debug build
mkdir -p debug
cd debug
cmake -DCMAKE_MODULE_PATH:PATH=$CMAKE_DIR -DCMAKE_VERBOSE_MAKEFILE=1 -DCMAKE_BUILD_TYPE=debug ../../cmake-d/tests
make
make test
