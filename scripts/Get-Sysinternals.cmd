@echo off
rem ===================================================================
rem                  Sysinternal Update Script
rem ===================================================================

setlocal enableextensions enabledelayedexpansion


rem ============
rem Custom Help Message
rem ============
if "%1" == "help" goto HELP

rem ============
rem Get the Installation folder
rem ============
if "%1" == "" (
    set TARGETPATH="C:\Program Files\Windows Sysinternals"
) else ( 
    set TARGETPATH="%1"
)

rem ============
rem Check For RoboCopy in the path
rem ============
for %%f in (robocopy.exe) do (
    if not exist "%%~dp$PATH:f" (
        echo ERROR:  %%f Executable is not in path
        goto EXIT
    )
)

rem ============
rem Copy the Files from live.sysinternals.com
rem ============
if exist %TARGETPATH% (
    robocopy.exe \\live.sysinternals.com\tools %TARGETPATH% *.* /COPY:DAT /PURGE /R:1 /W:3 /XF *.db *.url *.scr *.pdf About_This_Site.txt
) else (
    echo ERROR: [%TARGETPATH%]  doesn't exists
)
goto EXIT

rem ============
rem Help Command Display
rem ============
:HELP
echo Copies the Sysinternal Suite executables from \\live.sysinternals.com\tool
echo.
echo Get-Systinternals [path]
echo.
echo    path     The target folder for the local copy of SysInternal Suite
echo.

rem ============
rem Exit
rem ============
:EXIT
endlocal

