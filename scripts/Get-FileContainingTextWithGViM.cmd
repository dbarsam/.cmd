@echo off
setlocal enabledelayedexpansion
rem ===================================================================
rem                 Get Find Containing Text With GViM
rem ===================================================================

rem ============
rem Safety Check
rem ============
if "%1" == "" goto HELP
if "%1" == "help" goto HELP
if not "%4" == "" goto HELP

rem ============
rem Get the command
rem ============
for %%f in (%1) do (
    if exist %%~sf\nul (
        set GREPDIR=%1
    ) else (
        echo Cannot evaluate %1 as a directory
    )
)

if defined GREPDIR (
    for %%f in (grep.exe, xargs.exe, gvim.exe) do (
        if exist "%%~dp$PATH:f" (
            if %%f==grep.exe  set SCRIPTCOMMAND=%%f -il -R --include=%2 %3 %GREPDIR:\=/% ^|
            if %%f==xargs.exe set SCRIPTCOMMAND=!SCRIPTCOMMAND! %%f 
            if %%f==gvim.exe  set SCRIPTCOMMAND=!SCRIPTCOMMAND! %%f -p -c "set ic" -c "/%3"
        ) else (
            echo Cannot find %%f executable in the path
        )
    )
)

rem ============
rem Execute
rem ============
if defined SCRIPTCOMMAND echo "%SCRIPTCOMMAND%" && %SCRIPTCOMMAND%
goto EXIT

rem ============
rem Help Command Display
rem ============
:HELP
echo Finds files containing matching text and opens them with GViM
echo.
echo Get-FileContainingTextWithGViM [path] [filter [text]
echo    path     The search path
echo    filter   The file filter
echo    text     The search text
echo.
echo e.g.
echo     Get-FileContainingTextWithGViM . *.txt TEXT

rem ============
rem Exit
rem ============
:EXIT
endlocal
