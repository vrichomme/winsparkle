cmake_minimum_required(VERSION 3.0)

set(COMPONENT_NAME WinSparkle)	


file(GLOB_RECURSE INCLUDE_FILES *.h)
file(GLOB_RECURSE SRC_FILES *.cpp)
#file(GLOB RES_FILES ${TROPHY_ROOT_DIR}/Diagnostic/src/Resources/version_cmake.rc *.xml)
set(RES_FILES winsparkle.rc ../translations/translations.rc)
#set(MANIFEST_FILE ${TROPHY_ROOT_DIR}/Foundations/include/Common/AdminPrivilege.manifest)


source_group("include" FILES ${INCLUDE_FILES})
source_group("src" FILES ${SRC_FILES})
source_group("res" FILES ${RES_FILES})


# Retrieve nugets package
find_program(NUGET nuget PATHS ${CMAKE_SOURCE_DIR}/nuget_cli)
execute_process(COMMAND ${NUGET} install ${CMAKE_SOURCE_DIR}/packages.config -outputdirectory ${CMAKE_SOURCE_DIR}/packages)


#Create the executable COMPONENT_NAME.exe 
add_executable(
   ${COMPONENT_NAME}
   ${INCLUDE_FILES}
   ${SRC_FILES}
   ${RES_FILES}
)