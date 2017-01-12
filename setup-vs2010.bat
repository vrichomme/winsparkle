@echo off

set CMAKE_BIN_PATH=C:\Program Files\CMake\bin
set CMAKE_CMD="%CMAKE_BIN_PATH%\cmake.exe"
set BUILD_DIR=build


REM if defined VS70COMNTOOLS ( 
REM    SET PLATFORM_NAME=vc2003
REM )
REM if defined VS80COMNTOOLS  SET PLATFORM_NAME=vc2005
REM if defined VS90COMNTOOLS  SET PLATFORM_NAME=vc2008
REM if defined VS100COMNTOOLS SET PLATFORM_NAME=vc2010
REM if defined VS120COMNTOOLS SET PLATFORM_NAME=vc2013
REM if defined VS140COMNTOOLS (
REM    SET PLATFORM_NAME=vc2015
REM    echo VS2015 detected
REM )

if not exist %BUILD_DIR% (mkdir %BUILD_DIR%)
cd %BUILD_DIR%

echo [0] Win32
echo [1] Win64
set arch=
set /P arch=Please choose your architecture: 
If /I "%arch%"=="0" (
   %CMAKE_CMD% -G "Visual Studio 10 2010" ..
)
else if "%arch%"=="1"  (
   %CMAKE_CMD% -G "Visual Studio 10 2010 Win64" ..
)


cd ..

pause