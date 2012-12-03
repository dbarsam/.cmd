@echo off
setlocal
REM ===================================================================
REM                                 Get Base64
REM ===================================================================

rem ============
rem Custom Help Message
rem ============
if "%1" == "" goto HELP
if "%1" == "help" goto HELP
if not "%2" == "" goto HELP

rem ============
rem Get the executable from the path
rem ============
for %%f in (base64.exe) do (
    if exist "%%~dp$PATH:f" (
        set SCRIPTCOMMAND=%%f -n 0 %1 "%~dp1%~n1.txt"
    ) else (
        echo Cannot find %%f executable in the path
    )
)

rem ============
rem Execute
rem ============
if defined SCRIPTCOMMAND echo %SCRIPTCOMMAND% && %SCRIPTCOMMAND%
goto EXIT

rem ============
rem Help Command Display
rem ============
:HELP
echo Encoded the file contents to Base64
echo.
echo Get-Base64 [path]
echo.
echo    path     The target file to be encoded
echo.
echo e.g.
echo    Get-Base64 file.png 
echo.

rem ============
rem Exit
rem ============
:EXIT
endlocal
