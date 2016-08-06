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

# Do a unspecified build
mkdir -p unspecified
pushd unspecified
cmake -DCMAKE_MODULE_PATH:PATH=$CMAKE_DIR ../../cmake-d/tests
make
make test
popd

# Do a debug build
mkdir -p debug
pushd debug
cmake -DCMAKE_MODULE_PATH:PATH=$CMAKE_DIR -DCMAKE_VERBOSE_MAKEFILE=1 -DCMAKE_BUILD_TYPE=Debug ../../cmake-d/tests
make
make test
popd

# Do a release build
mkdir -p release
pushd release
cmake -DCMAKE_MODULE_PATH:PATH=$CMAKE_DIR -DCMAKE_BUILD_TYPE=Release ../../cmake-d/tests
make
make test
popd

# Do a relWithDebInfo build
mkdir -p relWithDebInfo
pushd relWithDebInfo
cmake -DCMAKE_MODULE_PATH:PATH=$CMAKE_DIR -DCMAKE_BUILD_TYPE=RelWithDebInfo ../../cmake-d/tests
make
make test
popd

# Do a minSizeRel build
mkdir -p minSizeRel
pushd minSizeRel
cmake -DCMAKE_MODULE_PATH:PATH=$CMAKE_DIR -DCMAKE_BUILD_TYPE=MinSizeRel ../../cmake-d/tests
make
make test
popd
