@echo off
REM ===================================================================
REM                  Dos Environment Set-up File
REM -------------------------------------------------------------------
REM                             Python
REM ===================================================================

REM ==============
REM Custom Aliases
REM ==============
doskey ;pyclean=del /s /f *.pyc
for %%p in ("%PROGRAMFILES%" "%PROGRAMFILES(x86)%") do (
    for %%v in (26 27) do (
        if exist "%%~p\python%%v\python.exe" (
            doskey ;p%%v="%%~p\python%%v\python.exe" $*
        )
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

