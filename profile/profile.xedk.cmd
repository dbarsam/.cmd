@echo off
REM ===================================================================
REM                  Dos Environment Set-up File
REM -------------------------------------------------------------------
REM                      Xbox 360 SDK tools.
REM ===================================================================

REM ==================
REM Custom Environment
REM ==================

REM Invoke XBOX's Environment
if exist "%XEDK%\bin\win32\xdkvars.bat" (
    call "%XEDK%\bin\win32\xdkvars.bat"
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

