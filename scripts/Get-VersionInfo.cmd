@echo off
rem ===================================================================
rem             Returns the Version Info of a File
rem ===================================================================
rem Reference:
rem     http://stackoverflow.com/questions/11090875/powershell-get-item-versioninfo-productversion-incorrect-different-than-wmi
rem ===================================================================
setlocal enableextensions enabledelayedexpansion

rem ============
rem Custom Help Message
rem ============
if [%~1]==[help] goto help
if [%~1]==[] goto help

rem ============
rem Ensure powershell is in the path
rem ============
for %%f in (powershell.exe) do (
    if not exist "%%~dp$PATH:f" (
        echo ERROR:  %%f Executable is not in path
        goto exit
    )
)

rem ============
rem Build The File Array
rem ============
for %%a in (%*) do (
    if not defined FILEARRAY (
        set FILEARRAY=\"%%~fa\"
    ) else ( 
        set "FILEARRAY=!FILEARRAY!,\"%%~fa\""
    )
)

rem ============
rem The Query
rem ============
powershell -command "&{@(!FILEARRAY!) | ForEach-Object {(get-item $_).VersionInfo | fl *}}"
goto :exit

rem ============
rem Help Command Display
rem ============
:help
echo Returns the Version Info of a file via Powershell
echo.
echo Get-VersionInfo file [file2 ... fileN]
echo.
echo    file        The file to query.
echo.

:exit
endlocal
