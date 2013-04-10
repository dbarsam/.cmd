@echo off
rem ===================================================================
rem                  Sysinternal Update Script
rem ===================================================================

setlocal enableextensions enabledelayedexpansion

rem ============
rem Custom Help Message
rem ============
if [%1]==[help] goto :HELP

rem ============
rem Get the Installation folder
rem ============
if [%1] == [] (
    set TARGETPATH="C:\Program Files\Windows Sysinternals"
) else ( 
    set TARGETPATH=%1
)

rem ============
rem Kill Any Existing Processes
rem ============
if not exist !TARGETPATH! (
    echo ERROR: [!TARGETPATH!]  doesn't exists
    goto EXIT
) else (
    for /f %%a in ('dir /b !TARGETPATH!') do (
        tasklist /NH | findstr /b /i %%a 
        if !ERRORLEVEL! == 0 (
            echo Killing %%a ...
            taskkill /im %%a /f
            set RUNNINGEXES=!RUNNINGEXES!;%%a
        )
    )
)

rem ============
rem Check For Wget in the path
rem ============
for %%f in (wget.exe) do (
    if exist "%%~dp$PATH:f" (
        set SCRIPTCOMMAND=wget.exe 
        set SCRIPTCOMMAND=!SCRIPTCOMMAND! --user-agent="Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6" 
        set SCRIPTCOMMAND=!SCRIPTCOMMAND! --referer="http://www.google.com" 
        set SCRIPTCOMMAND=!SCRIPTCOMMAND! --timestamping 
        set SCRIPTCOMMAND=!SCRIPTCOMMAND! --no-parent 
        set SCRIPTCOMMAND=!SCRIPTCOMMAND! --recursive 
        set SCRIPTCOMMAND=!SCRIPTCOMMAND! --cut-dirs=1 
        set SCRIPTCOMMAND=!SCRIPTCOMMAND! --no-check-certificate 
        set SCRIPTCOMMAND=!SCRIPTCOMMAND! --no-host-directories 
        set SCRIPTCOMMAND=!SCRIPTCOMMAND! --no-directories 
        set SCRIPTCOMMAND=!SCRIPTCOMMAND! --level=1 
        set SCRIPTCOMMAND=!SCRIPTCOMMAND! --directory-prefix=!TARGETPATH!
        set SCRIPTCOMMAND=!SCRIPTCOMMAND! --reject=txt,html,pdf,src 
        set SCRIPTCOMMAND=!SCRIPTCOMMAND! http://live.sysinternals.com/Tools
    ) else (
        echo Cannot find %%f executable in the path
    )
)

rem ============
rem Check For RoboCopy in the path
rem ============
rem for %%f in (robocopy.exe) do (
rem     if exist "%%~dp$PATH:f" (
rem         set SCRIPTCOMMAND=robocopy.exe
rem         set SCRIPTCOMMAND=%SCRIPTCOMMAND% \\live.sysinternals.com\tools
rem         set SCRIPTCOMMAND=%SCRIPTCOMMAND% %TARGETPATH%
rem         set SCRIPTCOMMAND=%SCRIPTCOMMAND% *.*
rem         set SCRIPTCOMMAND=%SCRIPTCOMMAND% /COPY:DAT
rem         set SCRIPTCOMMAND=%SCRIPTCOMMAND% /PURGE
rem         set SCRIPTCOMMAND=%SCRIPTCOMMAND% /R:1
rem         set SCRIPTCOMMAND=%SCRIPTCOMMAND% /W:3
rem         set SCRIPTCOMMAND=%SCRIPTCOMMAND% /XF *.db *.url *.scr *.pdf About_This_Site.txt
rem     ) else (
rem         echo Cannot find %%f executable in the path
rem     )
rem )

rem ============
rem Execute the Command
rem ============
if defined SCRIPTCOMMAND echo "!SCRIPTCOMMAND!" && !SCRIPTCOMMAND!

rem ============
rem Restart Any Existing Processes
rem ============
call :RESTART "%RUNNINGEXES%"
:RESTART
for /f "tokens=1* delims=;" %%i in ("%~1") do (
    echo Launching %%i
    pushd !TARGETPATH!
    start %%i
    popd
    call :RESTART "%%j"
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

