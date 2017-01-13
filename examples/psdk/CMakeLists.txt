cmake_minimum_required(VERSION 3.4)

set(COMPONENT_NAME example_psdk)	

add_definitions(-D_CONSOLE)

file(GLOB INCLUDE_FILES ${CMAKE_SOURCE_DIR}/examples/psdk/*.h)
file(GLOB SRC_FILES ${CMAKE_SOURCE_DIR}/examples/psdk/*.cpp ${CMAKE_SOURCE_DIR}/examples/psdk/*.c)
file(GLOB RES_FILES ${CMAKE_SOURCE_DIR}/examples/psdk/*.rc)

source_group("include" FILES ${INCLUDE_FILES})
source_group("src" FILES ${SRC_FILES})
source_group("res" FILES ${RES_FILES})

#if possible activate c++11
set (CMAKE_CXX_STANDARD 11)

#Create the executable COMPONENT_NAME.exe 
add_executable(
   ${COMPONENT_NAME}
   ${INCLUDE_FILES}
   ${SRC_FILES}
   ${RES_FILES}
)
#add include path
target_include_directories(${COMPONENT_NAME} PUBLIC ${CMAKE_SOURCE_DIR}/include)

# Add dependencies with WinSparkle
target_link_libraries (${COMPONENT_NAME} WinSparkle)