@echo off
rem ===================================================================
rem                   Invoke a Custom SVN Command
rem ===================================================================

setlocal enableextensions enabledelayedexpansion

rem ============
rem Custom Help Message
rem ============
if "%1" == "help" goto HELP

rem ============
rem Ensure SVN and Command are valid
rem ============
for %%f in (svn.exe diff.exe) do (
    if not exist "%%~dp$PATH:f" (
        echo ERROR:  %%f Executable is not in path
        goto EXIT
    )
)

rem ============
rem Custom Status Command
rem ============
if "%1" == "status" (
    set LOCALDIR=%2
    if defined LOCALDIR pushd !LOCALDIR!

    svn status --show-updates

    if defined LOCALDIR popd
    goto EXIT
)

rem ============
rem Custom Dry Run Command
rem ============
if "%1" == "dryrun" (
    set LOCALDIR=%2
    if defined LOCALDIR pushd !LOCALDIR!

    svn merge --dry-run -r BASE:HEAD .

    if defined LOCALDIR popd
    goto EXIT
)

rem ============
rem Custom Find Revision of Text Addition
rem ============
if "%1" == "findadd" (
    set LOCALDIR=%2
    if defined LOCALDIR pushd !LOCALDIR!

    for /f "tokens=1 delims=r " %%a in ('svn log %3 -q ^| findstr /r "^r"' ) do (
        echo Checking %3 r%%a:
        for /f "tokens=*" %%b in ('svn blame -r%%a:%%a %3 ^| findstr /n /v /c:"     -          -" ^| findstr /l /c:%4' ) do (
            echo %%b
        )
    )

    if defined LOCALDIR popd
    goto EXIT
)

rem ============
rem Custom Find Revision of Text Subtraction
rem ============
if "%1" == "findsub" (
    set LOCALDIR=%2
    if defined LOCALDIR pushd !LOCALDIR!

    for /f "tokens=1 delims=r " %%a in ('svn log %3 -q ^| findstr /r "^r"' ) do (
        echo Checking %3 r%%a:
        set /a PREV=%%a - 1
        for /f "tokens=*" %%b in ('svn diff --old=%3@!PREV! --new=%3@%%a --diff-cmd diff --diff-cmd diff -x "-i" 2^>nul ^| findstr /r "^^<.*" ^| findstr /c:%4') do (
            echo r%%a deleted %4
        )
    )

    if defined LOCALDIR popd
    goto EXIT
)

rem ============
rem Unsuported Command Error Handling
rem ============
echo ERROR:  [%1] is not supported by this script.  Try "%~n0 help".
goto EXIT

Rem ============
rem Help Command Display
rem ============
:HELP
Echo Invokes a custom SVN command.
echo.
echo Invoke-SVNCommand command [arguments]
echo.
echo    command     The custom svn command.
echo    arguments   The arguments for the command
echo.
echo Supported Commands:
echo    status    path
echo              path           The path to use in the command
echo.
echo    dryrun    path
echo              path           The path to use in the command
echo.
echo    findadd   path file text
echo              path           The path to use in the command
echo              file           The target file
echo              text           The search text
echo.
echo    findsub   path file text
echo              path           The path to use in the command
echo              file           The target file
echo              text           The search text
echo.

rem ============
rem Exit
rem ============
:EXIT
endlocal
