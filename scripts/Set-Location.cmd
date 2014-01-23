@echo off
rem ===================================================================
rem    Sets the current location in the Windows command line
rem ===================================================================

rem ============
rem Custom Help Message
rem ============
if "%~1"==""        goto :help

rem ============
rem Process Special Symbols
rem ============
if "%~1"=="-"       popd && goto :exit
if "%~1"=="."       pushd %CD% && goto :exit
if "%~1"==".."      pushd %CD%\.. &&  goto :exit

rem ============
rem Change Directory
rem ============
if exist %~s1\nul   pushd %1 && goto :exit

rem ============
rem Error Mesage
rem ============
echo Could not set %~1 as a location.
echo.

rem ============
rem Help Command Display
rem ============
:help
echo Sets the current location in the Windows command line
echo.
echo Set-Location .^|..^|-^|^<dir^>
echo.
echo    .     The current directory
echo    ..    Up one level from the current directory
echo    -     Peturn to the previous directory in the history
echo    ^<dir^> A valid directory
echo.
echo e.g.
echo    Set-Location .
echo    Set-Location ..
echo    Set-Location -
echo    Set-Location C:\Windows
echo.

:exit
