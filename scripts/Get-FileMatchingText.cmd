@echo off
setlocal
rem ===================================================================
rem                    Get Find Matching Text
rem ===================================================================

rem ============
rem Safety Check
rem ============
if "%1" == "" goto HELP
if "%1" == "help" goto HELP
if not "%3" == "" goto HELP

rem ============
rem Get the executable from the path
rem ============
for %%f in (%1) do (
    if exist %%~sf\nul (
        set FINDDIR=%1
    ) else (
        echo Cannot evaluate %1 as a directory
    )
)

if defined FINDDIR (
    for %%f in ("C:\Program Files (x86)\GnuWin32\bin\find.exe") do (
        if exist %%f (
            set SCRIPTCOMMAND=%%f %FINDDIR:\=/% -type f -name "%2" -print
        ) else (
            echo Cannot find %%f executable in the path
        )
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
echo Finds files with matching filename using UNIX find
echo.
echo Get-FileMatchingText [path] [filter]
echo    path     The search path
echo    filter   The file filter
echo.
echo e.g.
echo    Get-FileMatchingText . *.txt

rem ============
rem Exit
rem ============
:EXIT
endlocal
