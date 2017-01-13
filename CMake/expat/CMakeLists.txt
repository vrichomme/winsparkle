project(WinSparkle_expat)

cmake_minimum_required(VERSION 3.4)

# configuration options
set(XML_CONTEXT_BYTES 1024 CACHE STRING "Define to specify how much context to retain around the current parse point")
option(XML_DTD "Define to make parameter entity parsing functionality available" ON)
option(XML_NS "Define to make XML Namespaces functionality available" ON)

if(XML_DTD)
    set(XML_DTD 1)
else(XML_DTD)
    set(XML_DTD 0)
endif(XML_DTD)
if(XML_NS)
    set(XML_NS 1)
else(XML_NS)
    set(XML_NS 0)
endif(XML_NS)

include(ConfigureChecks.cmake)

include_directories(${CMAKE_BINARY_DIR} ${CMAKE_SOURCE_DIR}/lib)
if(MSVC)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS -wd4996)
endif(MSVC)
if(WIN32)
    add_definitions(-DWIN32)
    set(CMAKE_DEBUG_POSTFIX "d" CACHE STRING "Add a suffix, usually d on Windows")
endif(WIN32)

set(expat_SRCS
    lib/xmlparse.c
    lib/xmlrole.c
    lib/xmltok.c 
    lib/xmltok_impl.c 
    lib/xmltok_ns.c
)

if(BUILD_shared)
    set(_SHARED SHARED)
    if(WIN32)
        set(expat_SRCS ${expat_SRCS} lib/libexpat.def)
    endif(WIN32)
else(BUILD_shared)
    set(_SHARED STATIC)
    if(WIN32)
        add_definitions(-DXML_STATIC)
    endif(WIN32)
endif(BUILD_shared)

add_library(WinSparkle_expat ${_SHARED} ${expat_SRCS})

set(LIBCURRENT 7)   # sync
set(LIBREVISION 2)  # with
set(LIBAGE 6)       # configure.ac!
math(EXPR LIBCURRENT_MINUS_AGE "${LIBCURRENT} - ${LIBAGE}")

if(NOT WIN32)
    set_property(TARGET WinSparkle_expat PROPERTY VERSION ${LIBCURRENT_MINUS_AGE}.${LIBAGE}.${LIBREVISION})
    set_property(TARGET WinSparkle_expat PROPERTY SOVERSION ${LIBCURRENT_MINUS_AGE})
    set_property(TARGET WinSparkle_expat PROPERTY NO_SONAME ${NO_SONAME})
endif(NOT WIN32)




