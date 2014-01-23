@echo off
rem ===================================================================
rem                  Dos Environment Set-up File
rem ===================================================================

rem ==============
rem Environment Variables from the Command Line
rem ==============

set EMULATOR=%1

rem ==============
rem Custom Aliases
rem ==============
doskey ;alias=doskey /m
doskey ;path=@echo %%PATH:;=^&echo.%%
doskey ;history=doskey /h
doskey ;help=hh.exe ms-its:C:\WINDOWS\Help\ntcmds.chm::/ntcmds.htm
doskey ;profile=edit %~f0
doskey ;find=dir /s /b . ^| findstr /i /c:"$1" 
doskey ;grep=findstr /s /n /i /m /c:"$1" $2
doskey ;ex=explorer .
doskey ;desktop=pushd %USERPROFILE%\desktop
doskey ;pd=pushd $*
doskey ;po=popd
doskey ;prune=for /f "usebackq delims=" %%d in (`"dir /ad/b/s | sort /R"`) do @rd "%%d" 2^>^&1 ^| ^>nul findstr "The directory is not empty." ^|^| (@echo Deleted %%d)

rem ==============
rem Script Aliases
rem ==============
doskey ;sl-=%~dp0\scripts\Set-Location.cmd -
doskey ;sl=%~dp0\scripts\Set-Location.cmd $*
doskey ;version=%~dp0\scripts\Get-VersionInfo.cmd $*
doskey ;update=%~dp0\scripts\Update-EnvironmentVariables.cmd $*
doskey ;fgrep=%~dp0\scripts\Get-FileContainingText.cmd $*
doskey ;ggrep=%~dp0\scripts\Get-FileContainingTextWithGViM.cmd $*
doskey ;elevate=%~dp0\scripts\elevate.cmd $t $*

rem ============
rem External Configurations
rem ============
for %%f in (%~dpn0\%~n0.*.cmd) do (
    if exist %%f (
        call %%f
    )
)

goto exit
rem ==============
rem Error Handling
rem ==============
:error

rem ===================================================================
rem End of Script
rem ===================================================================
:exit

