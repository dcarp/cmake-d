#
# CMakeD - CMake module for D Language
#
# Copyright (c) 2007, Selman Ulug <selman.ulug@gmail.com>
# All rights reserved.
#
# See Copyright.txt for details.
#


# - Find GDC Include Path
#
#  GDC_INCLUDE_PATH = path to where object.d is found
#

SET(GDC_POSSIBLE_INCLUDE_PATHS
  /usr/include/d/4.1.2
  /usr/include/d/4.1.1
  /usr/include/d/4.1.0
  /usr/include/d/4.0.4
  /usr/include/d/4.0.3
  /usr/include/d/4.0.2
  /usr/include/d/4.0.1
  /usr/include/d/4.0.0
  /usr/include/d/4.0.6
  /usr/include/d/4.0.5
  /usr/include/d/3.4.4
  /usr/include/d/3.4.3
  /usr/include/d/3.4.2
  /usr/include/d/3.4.1
  /usr/include/d/3.4.0
  )

FIND_PATH(GDC_INCLUDE_PATH object.d
  ${GDC_POSSIBLE_INCLUDE_PATHS})

MARK_AS_ADVANCED(
  GDC_INCLUDE_PATH
  )
