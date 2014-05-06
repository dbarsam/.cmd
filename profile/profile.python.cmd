@echo off
REM ===================================================================
REM                  Dos Environment Set-up File
REM -------------------------------------------------------------------
REM                             Python
REM ===================================================================
REM ==============
REM Custom Aliases
REM ==============
doskey ;pyclean=del /s /f *.pyc *.pyo
setlocal enableextensions enabledelayedexpansion
for %%p in ("%PROGRAMFILES(x86)%" "%PROGRAMW6432%") do (
    for /f "delims=" %%d in ('dir /b "%%~p\python*" 2^>nul ^| findstr /i /r "python[0-9][0-9]*$"') do (
        if exist "%%p\%%d\python.exe" (
            set pver=%%d
            set pver=!pver:~6!
            if %%p=="%PROGRAMFILES(x86)%" doskey ;p!pver!32="%%~p\%%d\python.exe" $*
            if %%p=="%PROGRAMW6432%"      doskey ;p!pver!="%%~p\%%d\python.exe" $*
        )
    )
)
endlocal
goto EXIT
REM ==============
REM Error Handling
REM ==============
:ERROR

REM ===================================================================
REM End of Script
REM ===================================================================
:EXIT

