# define system dependent compiler flags

IF(CMAKE_COMPILER_IS_GDC)
	add_definitions(-DHAVE_CONFIG_H -Wall -Werror)
ELSE(CMAKE_COMPILER_IS_GDC)
	add_definitions(-version=HaveConfig)
ENDIF(CMAKE_COMPILER_IS_GDC)

