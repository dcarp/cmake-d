# Tell cmake our project only concerns the D language.
cmake_minimum_required(VERSION 2.8)
PROJECT (CMAKED2_TESTS D)
ADD_DEFINITIONS( -w -wi )
enable_testing()
ADD_SUBDIRECTORY (app_1)
ADD_SUBDIRECTORY (app_2)
ADD_SUBDIRECTORY (lib_1)
ADD_SUBDIRECTORY (app_3)
