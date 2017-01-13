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

set vs_index=8 9 10 11 12 14 15

REM set vs_index=
REM if defined VS80COMNTOOLS (
   REM SET INTERNAL_VER=8
   REM set vs_index=!vs_index! %INTERNAL_VER%
REM )
REM if defined VS90COMNTOOLS (
   REM SET INTERNAL_VER=9
   REM set vs_index=!vs_index! %INTERNAL_VER%
REM )
REM if defined VS100COMNTOOLS (
   REM SET INTERNAL_VER=10
   REM set vs_index=!vs_index! %INTERNAL_VER%
REM )
REM if defined VS110COMNTOOLS (
  
   REM SET INTERNAL_VER=11
   REM set vs_index=!vs_index! %INTERNAL_VER%
REM )
REM if defined VS120COMNTOOLS ( 
   REM SET INTERNAL_VER=12
   REM set vs_index=!vs_index! %INTERNAL_VER%
REM )
REM if defined VS140COMNTOOLS (
   REM SET INTERNAL_VER=14
   REM set vs_index=!vs_index! %INTERNAL_VER%
REM )
REM if defined VS150COMNTOOLS (
   REM SET INTERNAL_VER=15
   REM set vs_index=!vs_index! %INTERNAL_VER%
REM )
REM Remove space at the beginning 
REM echo %vs_index%
REM SET vs_index=%vs_index:~1%

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

REM set DEL_BUILD_FOLDER=
REM IF EXIST %BUILD_DIR% (
   REM CLS
REM :AskRemoveBuildDir
REM set DEL_BUILD_FOLDER=
REM set /P DEL_BUILD_FOLDER=%BUILD_DIR% already exists. Press y to remove (or q to quit) 
REM if /I "%DEL_BUILD_FOLDER%"=="y" (
REM   RD /S /Q %BUILD_DIR%
   REM goto AfterAskRemoveBuildDir
REM )
REM if /I "%DEL_BUILD_FOLDER%"=="q" (
   REM goto Exit
REM )
REM echo Wrong choice & goto AskRemoveBuildDir
REM :AfterAskRemoveBuildDir
REM )
if not exist %BUILD_DIR% (mkdir %BUILD_DIR%)

:AskArch
CLS
echo(
echo [0] Win64
echo [1] Win32
set ARCHCHOICE=
set /P ARCHCHOICE=Please enter number for architecture (or q to quit): 
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
echo Now calling cmake with the following cmd: 
echo %CMAKE_CMD% -G %CMAKE_GEN% ..\..
echo(
echo(
%CMAKE_CMD% -G %CMAKE_GEN% ..\..
REM %CMAKE_CMD% -G %CMAKE_GEN% ..\.. > setup-cmake-msvc.txt 2>&1

set LAUNCHSOLUTION=
set slnfile=
:AskLaunchSolution
IF %ERRORLEVEL% EQU 0 (
   CLS
   echo CMake success
   
   set /P LAUNCHSOLUTION=Would you like to launch the solution ? [y/n] 
   if /I "%LAUNCHSOLUTION%"=="y" (
      
	  for %%A in ("*.sln") DO (
		START %%A
		goto Exit
	  )
	  REM ECHO --- %slnfile% ---
      REM START WinSparkle.sln
      goto AfterAskLaunchSolution
   )
   if /I "%LAUNCHSOLUTION%"=="n" (
      goto Exit
   )
   echo Wrong choice & goto AskLaunchSolution
)
:AfterAskLaunchSolution

REM IF %ERRORLEVEL% NEQ 0 (



:Exit
cd %ORG_PWD%

pause