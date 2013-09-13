@echo off
setlocal
rem ===================================================================
rem                    Get File Containing Text
rem ===================================================================

rem ============
rem Safety Check
rem ============
if "%1" == "" goto help
if "%1" == "help" goto help
if not "%4" == "" goto help

rem ============
rem Test the first parameters as a directory
rem ============
if exist %~s1\nul (
    set GREPDIR=%1
) else (
    echo Cannot evaluate %1 as a directory
)

if defined GREPDIR (
    for %%f in (grep.exe) do (
        if exist "%%~dp$PATH:f" (
            set SCRIPTCOMMAND=%%f -il -R --include=%2 %3 %GREPDIR:\=/%
        ) else (
            echo Cannot find %%f executable in the path
        )
    )
)

rem ============
rem Execute
rem ============
if defined SCRIPTCOMMAND echo %SCRIPTCOMMAND% && %SCRIPTCOMMAND%
goto exit

rem ============
rem Help Command Display
rem ============
:help
echo Finds files containing matching text
echo.
echo Get-FileContainingText [path] [filter] [text]
echo    path     The search path
echo    filter   The file filter
echo    text     The search text
echo.
echo e.g.
echo     Get-FileContainingText . *.txt TEXT

rem ============
rem Exit
rem ============
:exit
setlocal
