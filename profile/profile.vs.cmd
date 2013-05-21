@echo off
REM ===================================================================
REM                  Dos Environment Set-up File
REM -------------------------------------------------------------------
REM                         Visual Studio
REM ===================================================================

REM ==================
REM Custom Environment
REM ==================

REM Invoke Visual Studio's Environment
if exist "%VS110COMNTOOLS%VsDevCmd.bat" (
    call "%VS110COMNTOOLS%VsDevCmd.bat"
    goto ENVDONE
) 
if exist "%VS100COMNTOOLS%vsvars32.bat" (
    call "%VS100COMNTOOLS%vsvars32.bat"
    goto ENVDONE
) 
if exist "%VS90COMNTOOLS%vsvars32.bat" (
    call "%VS90COMNTOOLS%vsvars32.bat"
    goto ENVDONE
) 
if exist "%VS80COMNTOOLS%vsvars32.bat" (
    call "%VS80COMNTOOLS%vsvars32.bat"
    goto ENVDONE
)
:ENVDONE

REM ==============
REM Custom Aliases
REM ==============
doskey ;dlldump=dumpbin /exports $t

goto EXIT
REM ==============
REM Error Handling
REM ==============
:ERROR

REM ===================================================================
REM End of Script
REM ===================================================================
:EXIT

