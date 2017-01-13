cmake_minimum_required(VERSION 3.4)

project(WinSparkle)

# add path to custom cmake modules
#set (CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMake")

add_definitions(-D_UNICODE -DUNICODE -DUSING_CMAKE -D_CRT_SECURE_NO_WARNINGS)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib/x64)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib/x64)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin/x64)
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin/x64)

# expat 
# We replace the original CMakeLists.txt
SET(EXPAT_ORG_MK ${CMAKE_SOURCE_DIR}/cmake/expat/CMakeLists.txt)
SET(EXPAT_NEW_MK ${CMAKE_SOURCE_DIR}/3rdparty/expat/expat)
file(COPY ${EXPAT_ORG_MK} DESTINATION ${EXPAT_NEW_MK})

# we only want to build static lib => disable other options
#FILE(READ 3rdparty/expat/expat/CMakeLists.txt EXPAT_CMAKELISTS)
#string(REPLACE "project(expat)" "project(WinSparkle_expat)" EXPAT_CMAKELISTS ${EXPAT_CMAKELISTS})
#FILE(WRITE 3rdparty/expat/expat/CMakeLists.txt ${EXPAT_CMAKELISTS})
SET(BUILD_tools OFF CACHE BOOL "build the xmlwf tool for expat library" )
SET(BUILD_examples OFF CACHE BOOL "build the examples for expat library")
SET(BUILD_tests OFF CACHE BOOL "build the tests for expat library")
SET(BUILD_shared OFF CACHE BOOL "build a shared expat library")
add_subdirectory(3rdparty/expat/expat)
set_property(TARGET WinSparkle_expat PROPERTY FOLDER "dependencies")
#set_property(TARGET expat PROPERTY PROJECT_LABEL "WinSparkle_expat")


# wxWidgets 
add_subdirectory(cmake/wxWidgets)
set_property(TARGET WinSparkle_wx PROPERTY FOLDER "dependencies")

# WinSparkle project
add_subdirectory(src)
add_subdirectory(examples/psdk)




