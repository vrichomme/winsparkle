@echo off
SETLOCAL EnableDelayedExpansion

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
 
REM We start to support from VS 2005
set  arrayline[8]=2005
set  arrayline[9]=2008
set  arrayline[10]=2010
set  arrayline[11]=2012
set  arrayline[12]=2013
set  arrayline[14]=2015
set  arrayline[15]=2017

set ORG_PWD=%~dp0
set CMAKE_BIN_PATH=C:\Program Files\CMake\bin
set CMAKE_CMD="%CMAKE_BIN_PATH%\cmake.exe"
set BUILD_DIR=build
set vs_detected=
if defined VS80COMNTOOLS (
   SET PRODUCT_VER=2005
   SET INTERNAL_VER=8
   set vs_detected=!vs_detected! %PRODUCT_VER%
)
if defined VS90COMNTOOLS (
   SET PRODUCT_VER=2008
   SET INTERNAL_VER=9
   SET vs_detected=!vs_detected! %PRODUCT_VER%
)
if defined VS100COMNTOOLS (
   SET PRODUCT_VER=2010
   SET INTERNAL_VER=10
   set vs_detected=!vs_detected! %PRODUCT_VER%
)
if defined VS110COMNTOOLS (
   SET PRODUCT_VER=2012
   SET INTERNAL_VER=11
   set vs_detected=!vs_detected! %PRODUCT_VER%
)
if defined VS120COMNTOOLS ( 
   SET PRODUCT_VER=2013
   SET INTERNAL_VER=12
   set vs_detected=!vs_detected! %PRODUCT_VER%
)
if defined VS140COMNTOOLS (
   SET PRODUCT_VER=2015
   SET INTERNAL_VER=14
   set vs_detected=!vs_detected! %PRODUCT_VER%
)
if defined VS150COMNTOOLS (
   SET PRODUCT_VER=2017
   SET INTERNAL_VER=15
   set vs_detected=!vs_detected! %PRODUCT_VER%
)
REM Remove spaces at the beginning 
SET vs_detected=%vs_detected:~1%
SET vs_index=%vs_index:~1%

echo %vs_index%
echo ---------------------------------------------
echo * Visual Studio detection:                  *
echo ---------------------------------------------
for %%a in (%vs_detected%) do (
   echo Visual Studio %%a
   echo/
)
REM for %%f in %vs_detected% do echo Visual Studio %%f
echo ---------------------------------------------
echo( 
echo(


REM echo %vs_detected%
REM for %%f in %vs_detected% do (
REM    echo "%%f"
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
REM ARCH is Win32 by default
set ARCH=
echo [0] Win32
echo [1] Win64
set ARCHCHOICE=
set /P ARCHCHOICE=Please choose your architecture (or q to quit): 
If /I "%ARCHCHOICE%"=="0" (
   %CMAKE_CMD% -G "Visual Studio 14 2015" ..
   goto AfterAskArch
)
if /I "%ARCHCHOICE%"=="1" (
   set ARCH=Win64
   %CMAKE_CMD% -G "Visual Studio 14 2015 Win64" ..
   goto AfterAskArch
)
if /I "%ARCHCHOICE%"=="q" (
   goto Exit
)
echo Incorrect input & goto AskArch
:AfterAskArch

:Exit
cd %ORG_PWD%

pause