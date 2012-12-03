@echo off
setlocal
rem ===================================================================
rem                    Get File Containing Text
rem ===================================================================

rem ============
rem Safety Check
rem ============
if "%1" == "" goto HELP
if "%1" == "help" goto HELP
if not "%4" == "" goto HELP

rem ============
rem Get the executable from the path
rem ============
for %%f in (%1) do (
    if exist %%~sf\nul (
        set GREPDIR=%1
    ) else (
        echo Cannot evaluate %1 as a directory
    )
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
goto EXIT

rem ============
rem Help Command Display
rem ============
:HELP
echo Finds files containing matching text
echo.
echo Get-FileContainingText [path] [filter [text]
echo    path     The search path
echo    filter   The file filter
echo    text     The search text
echo.
echo e.g.
echo     Get-FileContainingText . *.txt TEXT

rem ============
rem Exit
rem ============
:EXIT
setlocal
