@echo off
SETLOCAL EnableDelayedExpansion

set ORG_PWD=%~dp0
set CMAKE_BIN_PATH=C:\Program Files\CMake-3.7.1\bin
set CMAKE_CMD="%CMAKE_BIN_PATH%\cmake.exe"


REM SET /a count=5
REM for /l %%a in (1,1,%count%) do call set "Myvar=%%Myvar%%, %%a"
REM ECHO %Myvar:~2%
REM PAUSE 
CLS
echo( 
echo *******************************************************
echo Helper script to generate makefiles/projects with cmake
echo *******************************************************
echo(
 
REM Check cmake is in our path
if not exist %CMAKE_CMD% (
   echo Cannot find %CMAKE_CMD%. 
   echo Please update CMAKE_BIN_PATH inside this script.
   echo(
   goto Exit
)
 
REM We start to support from VS 2005
set  arrayline[8]=2005
set  arrayline[9]=2008
set  arrayline[10]=2010
set  arrayline[11]=2012
set  arrayline[12]=2013
set  arrayline[14]=2015
set  arrayline[15]=2017


set vs_index=
if defined VS80COMNTOOLS (
   SET INTERNAL_VER=8
   set vs_index=!vs_index! %INTERNAL_VER%
)
if defined VS90COMNTOOLS (
   SET INTERNAL_VER=9
   set vs_index=!vs_index! %INTERNAL_VER%
)
if defined VS100COMNTOOLS (
   SET INTERNAL_VER=10
   set vs_index=!vs_index! %INTERNAL_VER%
)
if defined VS110COMNTOOLS (
  
   SET INTERNAL_VER=11
   set vs_index=!vs_index! %INTERNAL_VER%
)
if defined VS120COMNTOOLS ( 
   SET INTERNAL_VER=12
   set vs_index=!vs_index! %INTERNAL_VER%
)
if defined VS140COMNTOOLS (
   SET INTERNAL_VER=14
   set vs_index=!vs_index! %INTERNAL_VER%
)
if defined VS150COMNTOOLS (
   SET INTERNAL_VER=15
   set vs_index=!vs_index! %INTERNAL_VER%
)
REM Remove space at the beginning 
SET vs_index=%vs_index:~1%

echo ---------------------------------------------
echo * Visual Studio detection:                  *
echo ---------------------------------------------
for %%a in (%vs_index%) do (
   echo [%%a] Visual Studio !arrayline[%%a]!
)
echo ---------------------------------------------
set VSINDEXCHOICE=
set /P VSINDEXCHOICE=Please enter the index (ex 14 to generate for VS2015): 
set VSNUM=%VSINDEXCHOICE%
set VSVER=!arrayline[%VSINDEXCHOICE%]!
set BUILD_DIR=build\msvc%VSVER%
REM echo %VSNUM% %VSVER% %BUILD_DIR%
 
REM echo %vs_detected%
REM for %%f in %vs_detected% do (
REM    echo "%%f"
REM )

:AskRemoveBuildDir
set DEL_BUILD_FOLDER=
IF EXIST %BUILD_DIR% (
   CLS
   set /P DEL_BUILD_FOLDER=%BUILD_DIR% already exists. Press y to remove or q to quit 
   if /I "%DEL_BUILD_FOLDER%"=="y" (
     echo 0
     RD /S /Q %BUILD_DIR%
     goto AfterAskRemoveBuildDir
   )
   If /I "%DEL_BUILD_FOLDER%"=="q" (
      echo 3
      goto Exit
   )
REM   echo Wrong choice & goto AskRemoveBuildDir
)
:AfterAskRemoveBuildDir
if not exist %BUILD_DIR% (mkdir %BUILD_DIR%)

:AskArch
echo [0] Win64
echo [1] Win32
set ARCHCHOICE=
set /P ARCHCHOICE=Please choose your architecture (or q to quit): 
if /I "%ARCHCHOICE%"=="0" (
   set VSARCH=Win64
   goto AfterAskArch
)
if /I "%ARCHCHOICE%"=="1" (
   set VSARCH=
   goto AfterAskArch
)
if /I "%ARCHCHOICE%"=="q" (
   goto Exit
)
echo Wrong choice & goto AskArch
:AfterAskArch

cd %BUILD_DIR%
set CMAKE_GEN="Visual Studio %VSNUM% %VSVER% %VSARCH%"
CLS
echo(
echo Now calling cmake with the generator %CMAKE_GEN%: 
echo(
echo(
%CMAKE_CMD% -G %CMAKE_GEN% ..\..
REM %CMAKE_CMD% -G %CMAKE_GEN% ..\.. > setup-cmake-msvc.txt 2>&1


:Exit
cd %ORG_PWD%

pause