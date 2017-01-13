cmake_minimum_required(VERSION 3.4)

set(COMPONENT_NAME WinSparkle)	


add_definitions(-DXML_STATIC -DBUILDING_WIN_SPARKLE -DWINSPARKLE_EXPORTS)

file(GLOB_RECURSE INCLUDE_FILES *.h)
file(GLOB_RECURSE SRC_FILES *.cpp *.manifest)
set(RES_FILES winsparkle.rc ../translations/translations.rc)

source_group("include" FILES ${INCLUDE_FILES})
source_group("src" FILES ${SRC_FILES})
source_group("res" FILES ${RES_FILES})


# Retrieve gettext package
find_program(NUGET nuget PATHS ${CMAKE_SOURCE_DIR}/nuget_cli)
execute_process(COMMAND ${NUGET} install ${CMAKE_SOURCE_DIR}/packages.config -outputdirectory ${CMAKE_SOURCE_DIR}/packages)

# Execute gettext for translations
find_program(MSGFMT msgfmt PATHS ${CMAKE_SOURCE_DIR}/packages)
if(NOT MSGFMT)
  message(FATAL_ERROR "Cannot find msgfmt binary. Please check that Gettext package is available inside packages folder")
endif()
file(GLOB INPUT_FILES ${CMAKE_SOURCE_DIR}/translations/*.po)
foreach(INPUT_FILE ${INPUT_FILES})
   string(REPLACE ".po" ".mo" OUTPUT_FILE ${INPUT_FILE})
   #message(STATUS "${MSGFMT} -c ${INPUT} -o ${OUTPUT_FILE} ${INPUT_FILE}")
   execute_process(COMMAND ${MSGFMT} -c ${INPUT} -o ${OUTPUT_FILE} ${INPUT_FILE})
endforeach()

#if possible activate c++11
set (CMAKE_CXX_STANDARD 11)

#Create the executable COMPONENT_NAME.exe 
add_library(${COMPONENT_NAME} SHARED
   ${INCLUDE_FILES}
   ${SRC_FILES}
   ${RES_FILES}
)

# Add include path
target_include_directories(${COMPONENT_NAME} PUBLIC 
   ${CMAKE_SOURCE_DIR}/3rdparty/expat/expat/lib 
   ${CMAKE_SOURCE_DIR}/3rdparty/wxWidgets_setup_h
   ${CMAKE_SOURCE_DIR}/3rdparty/wxWidgets/include
   ${CMAKE_SOURCE_DIR}/include
)
# Add non default windows libraries
target_link_libraries (${COMPONENT_NAME} 
   comctl32.lib rpcrt4.lib version.lib wininet.lib
)
# Add dependencies with expat and WinSparkle_wx
target_link_libraries (${COMPONENT_NAME} WinSparkle_expat WinSparkle_wx)