cmake_minimum_required(VERSION 3.4)

project(WinSparkle)

# add path to custom cmake modules
set (CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMake")

add_definitions(-D_UNICODE -DUNICODE -DUSING_CMAKE -D_CRT_SECURE_NO_WARNINGS -DXML_STATIC -DBUILDING_WIN_SPARKLE -DWINSPARKLE_EXPORTS)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib/x64)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib/x64)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin/x64)
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin/x64)

# WinSparkle project
add_subdirectory(src)
add_subdirectory(examples/psdk)

# expat 
# we only want to build static lib => disable other options
#FILE(READ 3rdparty/expat/expat/CMakeLists.txt EXPAT_CMAKELISTS)
#string(REPLACE "project(expat)" "project(WinSparkle_expat)" EXPAT_CMAKELISTS ${EXPAT_CMAKELISTS})
#FILE(WRITE 3rdparty/expat/expat/CMakeLists.txt ${EXPAT_CMAKELISTS})



SET(BUILD_tools OFF CACHE BOOL "build the xmlwf tool for expat library" )
SET(BUILD_examples OFF CACHE BOOL "build the examples for expat library")
SET(BUILD_tests OFF CACHE BOOL "build the tests for expat library")
SET(BUILD_shared OFF CACHE BOOL "build a shared expat library")
add_subdirectory(3rdparty/expat/expat)

# wxWidgets 
add_subdirectory(cmake/wxWidgets)
