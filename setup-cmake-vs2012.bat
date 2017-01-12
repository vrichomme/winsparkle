@echo off

set ORG_PWD=%~dp0
set CMAKE_BIN_PATH=C:\Program Files\CMake\bin
set CMAKE_CMD="%CMAKE_BIN_PATH%\cmake.exe"
set BUILD_DIR=build



REM if defined VS100COMNTOOLS SET PLATFORM_NAME=vc2010
REM if defined VS110COMNTOOLS SET PLATFORM_NAME=vc2012
REM if defined VS120COMNTOOLS SET PLATFORM_NAME=vc2013
REM if defined VS140COMNTOOLS (
REM    SET PLATFORM_NAME=vc2015
REM    echo VS2015 detected
REM )

IF EXIST %BUILD_DIR% (
   echo I need to delete cmake cache %BUILD_DIR% folder
   set DEL_BUILD_FOLDER=
   set /P DEL_BUILD_FOLDER=Press y or n: 
   If /I "%DEL_BUILD_FOLDER%"=="y" (
     RD /S /Q %BUILD_DIR%
   )
   If /I "%DEL_BUILD_FOLDER%"=="n" (
      goto Exit
   )
)

if not exist %BUILD_DIR% (mkdir %BUILD_DIR%)
cd %BUILD_DIR%

:AskArch
echo [0] Win32
echo [1] Win64
set ARCH=
set /P ARCH=Please choose your architecture (or q to quit): 
If /I "%ARCH%"=="0" (
   %CMAKE_CMD% -G "Visual Studio 11 2012" ..
   goto AfterAskArch
)
if /I "%ARCH%"=="1" (
   %CMAKE_CMD% -G "Visual Studio 11 2012 Win64" ..
   goto AfterAskArch
)
if /I "%ARCH%"=="q" (
   goto Exit
)
echo Incorrect input & goto AskArch
:AfterAskArch

:Exit
cd %ORG_PWD%

pause