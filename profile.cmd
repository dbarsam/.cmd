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
doskey ;history=doskey /h
doskey ;help=hh.exe ms-its:C:\WINDOWS\Help\ntcmds.chm::/ntcmds.htm
doskey ;profile=edit %~f0
doskey ;find=dir /s /b . ^| findstr /i /c:"$1" 
doskey ;grep=findstr /s /n /i /m /c:"$1" $2
doskey ;ex=explorer .
doskey ;pd=pushd $*
doskey ;po=popd

rem ==============
rem Script Aliases
rem ==============
doskey ;fgrep=%~dp0\scripts\Get-FileContainingText.cmd $*
doskey ;ggrep=%~dp0\scripts\Get-FileContainingTextWithGViM.cmd $*
doskey ;elevate=%~dp0\scripts\elevate.cmd $t

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

