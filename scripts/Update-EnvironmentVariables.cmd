@echo off
rem ===================================================================
rem   Updates the Environment Variables within the Current Session
rem ===================================================================
rem Reference:
rem     http://stackoverflow.com/questions/171588/is-there-a-command-to-refresh-environment-variables-from-the-command-prompt-in-w
rem ===================================================================

rem ============
rem Custom Help Message
rem ============
if [%1]==[help] goto help

rem ============
rem Safety Check
rem ============
if not exist %~dpn0.vbs (
    echo The companion script [%~dpn0.vbs] does not exist.
    goto exit
)

rem ============
rem Backup Current Directory
rem ============
pushd %~dp0

rem ============
rem Local\Global Shenanigans:
rem 1) Set Up our Environment Variable Filter in a local block
rem 2) But pass that variable to the update function to execute globaly
rem ============
setlocal enableextensions enabledelayedexpansion
if "%~1"=="" (
    set ENVVARFILTER=^=
    echo Updating all variables
) else (
    for %%a in (%*) do (
        if not defined ENVVARFILTER (
            set ENVVARFILTER=%%a
        ) else ( 
            set "ENVVARFILTER=!ENVVARFILTER! %%a"
        )
    )
    echo Updating [!ENVVARFILTER!] variables
)
endlocal & call :update "%ENVVARFILTER%"

rem ============
rem Restore Current Directory
rem ============
popd
goto exit

rem ============
rem The Update Function
rem ============
:update
for /f "tokens=*" %%a in ('cscript %~n0.vbs ^| find /i "set" ^| findstr /i %1') do (
    echo %%a && %%a
)
goto :eof

rem ============
rem Help Command Display
rem ============
:help
echo Updates Environment Variables in the Command Shell session.
echo.
echo Update-EnvironmentVariables [[variable] ... [variable]]
echo.
echo    variable    if specified, the script will only update the variable instead of all variables
echo.

rem ============
rem Exit
rem ============
:exit

