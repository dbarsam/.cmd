@echo off
REM ===================================================================
REM                  Dos Environment Set-up File
REM ===================================================================

REM ==============
REM Environment Variables from the Command Line
REM ==============

set EMULATOR=%1

REM ==============
REM Custom Aliases
REM ==============
doskey ;alias=doskey /m
doskey ;history=doskey /h
doskey ;help=hh.exe ms-its:C:\WINDOWS\Help\ntcmds.chm::/ntcmds.htm
doskey ;profile=edit %~f0
doskey ;find=dir /s /b . ^| findstr /i /c:"$1" 
doskey ;grep=findstr /s /n /i /m /c:"$1" $2
doskey ;ex=explorer .
doskey ;pd=pushd
doskey ;po=popd

REM ============
REM External Configurations
REM ============
for %%f in (%~dpn0\%~n0.*.cmd) do (
    if exist %%f (
        call %%f
    )
)

goto EXIT
REM ==============
REM Error Handling
REM ==============
:ERROR

REM ===================================================================
REM End of Script
REM ===================================================================
:EXIT

